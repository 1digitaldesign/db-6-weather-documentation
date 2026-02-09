#!/usr/bin/env python3
"""
Generate Large Dataset Script for db-1 Airplane Tracking Database
Generates at least 1 GB of realistic aircraft tracking data.
"""

import sys
import json
import logging
from pathlib import Path
from datetime import datetime, timedelta
import random
import string

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

BASE_DIR = Path(__file__).parent.parent
DATA_DIR = BASE_DIR / 'data'
OUTPUT_DIR = DATA_DIR
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

TARGET_SIZE_GB = 1.0
TARGET_SIZE_BYTES = TARGET_SIZE_GB * 1024 * 1024 * 1024

# US Geographic Coverage
US_BOUNDS = {'west': -125.0, 'east': -66.0, 'south': 24.0, 'north': 50.0}

def generate_hex_code():
    """Generate realistic aircraft hex code (6 hex digits)."""
    return ''.join(random.choices('0123456789ABCDEF', k=6))

def generate_flight_number():
    """Generate realistic flight number."""
    airlines = ['AA', 'UA', 'DL', 'WN', 'AS', 'B6', 'F9', 'NK']
    return f"{random.choice(airlines)}{random.randint(100, 9999)}"

def generate_coordinates():
    """Generate realistic US coordinates."""
    lat = random.uniform(US_BOUNDS['south'], US_BOUNDS['north'])
    lon = random.uniform(US_BOUNDS['west'], US_BOUNDS['east'])
    return lat, lon

def generate_receiver_id():
    """Generate receiver ID."""
    return f"REC-{random.randint(1000, 9999)}"

def generate_aircraft_position_history_sql(target_bytes):
    """Generate aircraft_position_history data - main data generator."""
    sql_lines = []
    current_size = 0
    records = 0
    
    # Generate data for last 90 days, every 15 seconds per aircraft
    start_date = datetime.now() - timedelta(days=90)
    aircraft_count = 6000  # 6000 unique aircraft
    
    logger.info(f"Generating aircraft_position_history: {aircraft_count} aircraft over 90 days")
    
    hex_codes = [generate_hex_code() for _ in range(aircraft_count)]
    
    # Generate positions every 15 seconds
    time_interval = timedelta(seconds=15)
    current_time = start_date
    
    batch_size = 1000
    batch = []
    
    # Generate enough data to exceed target
    days_to_generate = 90
    positions_per_day = 24 * 60 * 4  # Every 15 minutes = 96 positions per day
    
    total_positions_needed = int((target_bytes * 0.8) / 200)  # Estimate ~200 bytes per record
    days_needed = total_positions_needed // (aircraft_count * positions_per_day)
    
    logger.info(f"Will generate {days_needed} days of data to reach target")
    
    for day_offset in range(min(days_needed, days_to_generate)):
        current_time = start_date + timedelta(days=day_offset)
        for hour in range(24):
            for minute in range(0, 60, 15):  # Every 15 minutes
                timestamp = current_time + timedelta(hours=hour, minutes=minute)
                for hex_code in hex_codes:
                    lat, lon = generate_coordinates()
                    altitude = random.randint(0, 45000)
                    speed = random.randint(100, 600)
                    track = random.randint(0, 359)
                    vertical_rate = random.randint(-5000, 5000)
                    
                    batch.append(f"('{hex_code}', {lat:.7f}, {lon:.7f}, {altitude}, {speed}, {track}, {vertical_rate}, '{timestamp.isoformat()}')")
                    
                    if len(batch) >= batch_size:
                        sql = f"INSERT INTO aircraft_position_history (hex, lat, lon, altitude, speed, track, vertical_rate, timestamp) VALUES\n"
                        sql += ",\n".join(batch) + ";\n\n"
                        sql_lines.append(sql)
                        current_size += len(sql.encode('utf-8'))
                        records += len(batch)
                        batch = []
                        
                        if current_size >= target_bytes * 0.8:
                            break
                
                if current_size >= target_bytes * 0.8:
                    break
            if current_size >= target_bytes * 0.8:
                break
        if current_size >= target_bytes * 0.8:
            break
    
    # Flush remaining batch
    if batch:
        sql = f"INSERT INTO aircraft_position_history (hex, lat, lon, altitude, speed, track, vertical_rate, timestamp) VALUES\n"
        sql += ",\n".join(batch) + ";\n\n"
        sql_lines.append(sql)
        records += len(batch)
    
    logger.info(f"Generated {records:,} position history records ({current_size / 1024 / 1024:.2f} MB)")
    return sql_lines, current_size

def generate_aircraft_real_sql():
    """Generate current aircraft positions."""
    sql_lines = []
    aircraft_count = 5000
    
    logger.info(f"Generating aircraft_real: {aircraft_count} current positions")
    
    batch_size = 500
    batch = []
    
    for i in range(aircraft_count):
        hex_code = generate_hex_code()
        flight = generate_flight_number() if random.random() > 0.1 else None
        lat, lon = generate_coordinates()
        altitude = random.randint(0, 45000)
        speed = random.randint(100, 600)
        track = random.randint(0, 359)
        vertical_rate = random.randint(-5000, 5000)
        squawk = f"{random.randint(1000, 7777):04d}" if random.random() > 0.2 else None
        receiver_id = generate_receiver_id()
        
        flight_str = f"'{flight}'" if flight else "NULL"
        squawk_str = f"'{squawk}'" if squawk else "NULL"
        
        batch.append(f"('{hex_code}', {flight_str}, {lat:.7f}, {lon:.7f}, {altitude}, {speed}, {track}, {vertical_rate}, {squawk_str}, '{receiver_id}')")
        
        if len(batch) >= batch_size:
            sql = f"INSERT INTO aircraft_real (hex, flight, lat, lon, altitude, speed, track, vertical_rate, squawk, receiver_id) VALUES\n"
            sql += ",\n".join(batch) + "\nON CONFLICT (hex) DO UPDATE SET lat = EXCLUDED.lat, lon = EXCLUDED.lon, altitude = EXCLUDED.altitude, speed = EXCLUDED.speed, seen_at = EXCLUDED.seen_at;\n\n"
            sql_lines.append(sql)
            batch = []
    
    if batch:
        sql = f"INSERT INTO aircraft_real (hex, flight, lat, lon, altitude, speed, track, vertical_rate, squawk, receiver_id) VALUES\n"
        sql += ",\n".join(batch) + "\nON CONFLICT (hex) DO UPDATE SET lat = EXCLUDED.lat, lon = EXCLUDED.lon, altitude = EXCLUDED.altitude, speed = EXCLUDED.speed, seen_at = EXCLUDED.seen_at;\n\n"
        sql_lines.append(sql)
    
    return sql_lines

def generate_aircraft_sessions_sql():
    """Generate aircraft sessions."""
    sql_lines = []
    session_count = 10000
    
    logger.info(f"Generating aircraft_sessions_real: {session_count} sessions")
    
    batch_size = 500
    batch = []
    
    for i in range(session_count):
        hex_code = generate_hex_code()
        flight = generate_flight_number() if random.random() > 0.1 else None
        receiver_id = generate_receiver_id()
        first_seen = datetime.now() - timedelta(days=random.randint(0, 90))
        last_seen = first_seen + timedelta(hours=random.randint(1, 12))
        ended_at = last_seen if random.random() > 0.1 else None
        
        flight_str = f"'{flight}'" if flight else "NULL"
        ended_str = f"'{ended_at.isoformat()}'" if ended_at else "NULL"
        
        batch.append(f"('{hex_code}', {flight_str}, '{receiver_id}', '{first_seen.isoformat()}', '{last_seen.isoformat()}', {ended_str})")
        
        if len(batch) >= batch_size:
            sql = f"INSERT INTO aircraft_sessions_real (hex, flight, receiver_id, first_seen, last_seen, ended_at) VALUES\n"
            sql += ",\n".join(batch) + "\nON CONFLICT (hex) DO UPDATE SET last_seen = EXCLUDED.last_seen, ended_at = EXCLUDED.ended_at;\n\n"
            sql_lines.append(sql)
            batch = []
    
    if batch:
        sql = f"INSERT INTO aircraft_sessions_real (hex, flight, receiver_id, first_seen, last_seen, ended_at) VALUES\n"
        sql += ",\n".join(batch) + "\nON CONFLICT (hex) DO UPDATE SET last_seen = EXCLUDED.last_seen, ended_at = EXCLUDED.ended_at;\n\n"
        sql_lines.append(sql)
    
    return sql_lines

def generate_collision_alerts_sql():
    """Generate collision alerts."""
    sql_lines = []
    alert_count = 50000
    
    logger.info(f"Generating collision_alerts: {alert_count} alerts")
    
    batch_size = 1000
    batch = []
    
    for i in range(alert_count):
        hex1 = generate_hex_code()
        hex2 = generate_hex_code()
        flight1 = generate_flight_number() if random.random() > 0.2 else None
        flight2 = generate_flight_number() if random.random() > 0.2 else None
        horizontal_distance = random.uniform(0.1, 10.0)
        vertical_distance = random.randint(0, 5000)
        severity = random.choice(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL'])
        detected_at = datetime.now() - timedelta(days=random.randint(0, 90))
        resolved_at = detected_at + timedelta(minutes=random.randint(1, 60)) if random.random() > 0.3 else None
        
        flight1_str = f"'{flight1}'" if flight1 else "NULL"
        flight2_str = f"'{flight2}'" if flight2 else "NULL"
        resolved_str = f"'{resolved_at.isoformat()}'" if resolved_at else "NULL"
        
        batch.append(f"('{hex1}', '{hex2}', {flight1_str}, {flight2_str}, {horizontal_distance:.3f}, {vertical_distance}, '{severity}', '{detected_at.isoformat()}', {resolved_str})")
        
        if len(batch) >= batch_size:
            sql = f"INSERT INTO collision_alerts (hex1, hex2, flight1, flight2, horizontal_distance_nm, vertical_distance_ft, severity, detected_at, resolved_at) VALUES\n"
            sql += ",\n".join(batch) + ";\n\n"
            sql_lines.append(sql)
            batch = []
    
    if batch:
        sql = f"INSERT INTO collision_alerts (hex1, hex2, flight1, flight2, horizontal_distance_nm, vertical_distance_ft, severity, detected_at, resolved_at) VALUES\n"
        sql += ",\n".join(batch) + ";\n\n"
        sql_lines.append(sql)
    
    return sql_lines

def generate_risk_assessments_sql():
    """Generate risk assessments."""
    sql_lines = []
    assessment_count = 50000
    
    logger.info(f"Generating risk_assessments: {assessment_count} assessments")
    
    batch_size = 1000
    batch = []
    
    for i in range(assessment_count):
        hex1 = generate_hex_code()
        hex2 = generate_hex_code()
        flight1 = generate_flight_number() if random.random() > 0.2 else None
        flight2 = generate_flight_number() if random.random() > 0.2 else None
        risk_score = random.uniform(0.0, 1.0)
        horizontal_distance = random.uniform(0.1, 10.0)
        vertical_distance = random.randint(0, 5000)
        closure_rate = random.uniform(0, 500)
        time_to_cpa = random.randint(0, 3600)
        risk_level = random.choice(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL'])
        detected_at = datetime.now() - timedelta(days=random.randint(0, 90))
        resolved_at = detected_at + timedelta(minutes=random.randint(1, 60)) if random.random() > 0.3 else None
        
        flight1_str = f"'{flight1}'" if flight1 else "NULL"
        flight2_str = f"'{flight2}'" if flight2 else "NULL"
        resolved_str = f"'{resolved_at.isoformat()}'" if resolved_at else "NULL"
        
        batch.append(f"('{hex1}', '{hex2}', {flight1_str}, {flight2_str}, {risk_score:.4f}, {horizontal_distance:.3f}, {vertical_distance}, {closure_rate:.2f}, {time_to_cpa}, '{risk_level}', '{detected_at.isoformat()}', {resolved_str})")
        
        if len(batch) >= batch_size:
            sql = f"INSERT INTO risk_assessments (hex1, hex2, flight1, flight2, risk_score, horizontal_distance_nm, vertical_distance_ft, closure_rate_knots, time_to_cpa_seconds, risk_level, detected_at, resolved_at) VALUES\n"
            sql += ",\n".join(batch) + ";\n\n"
            sql_lines.append(sql)
            batch = []
    
    if batch:
        sql = f"INSERT INTO risk_assessments (hex1, hex2, flight1, flight2, risk_score, horizontal_distance_nm, vertical_distance_ft, closure_rate_knots, time_to_cpa_seconds, risk_level, detected_at, resolved_at) VALUES\n"
        sql += ",\n".join(batch) + ";\n\n"
        sql_lines.append(sql)
    
    return sql_lines

def main():
    """Generate large dataset."""
    logger.info(f"Starting data generation for db-1 (target: {TARGET_SIZE_GB} GB)")
    
    all_sql = []
    
    # Generate position history (bulk of data)
    position_sql, position_size = generate_aircraft_position_history_sql(TARGET_SIZE_BYTES)
    all_sql.extend(position_sql)
    
    # Generate other tables
    all_sql.extend(generate_aircraft_real_sql())
    all_sql.extend(generate_aircraft_sessions_sql())
    all_sql.extend(generate_collision_alerts_sql())
    all_sql.extend(generate_risk_assessments_sql())
    
    # Write to file
    output_file = OUTPUT_DIR / 'data_large.sql'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("-- Large dataset for db-1 Airplane Tracking\n")
        f.write(f"-- Generated: {datetime.now().isoformat()}\n")
        f.write(f"-- Target size: {TARGET_SIZE_GB} GB\n\n")
        f.writelines(all_sql)
    
    file_size = output_file.stat().st_size
    logger.info(f"Generated data file: {output_file}")
    logger.info(f"File size: {file_size / 1024 / 1024 / 1024:.2f} GB")
    
    if file_size >= TARGET_SIZE_BYTES:
        logger.info("✅ Target size achieved!")
    else:
        logger.warning(f"⚠️  File size ({file_size / 1024 / 1024 / 1024:.2f} GB) is below target ({TARGET_SIZE_GB} GB)")

if __name__ == '__main__':
    main()
