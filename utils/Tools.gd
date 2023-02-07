extends Node

class Date:
	
	enum Month { JAN = 1, FEB = 2, MAR = 3, APR = 4, MAY = 5, JUN = 6, JUL = 7,
		AUG = 8, SEP = 9, OCT = 10, NOV = 11, DEC = 12 }
	
	static func get_days_in_month(month : int, year : int) -> int:
		var number_of_days : int
		if(month == Month.APR || month == Month.JUN || month == Month.SEP
				|| month == Month.NOV):
			number_of_days = 30
		elif(month == Month.FEB):
			var is_leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
			if(is_leap_year):
				number_of_days = 29
			else:
				number_of_days = 28
		else:
			number_of_days = 31
		
		return number_of_days
	
	static func datetime_to_prev_year(datetime: Dictionary):
		var new_datetime = datetime.duplicate(true)
		new_datetime.year = datetime.year - 1
		return new_datetime
	
	static func datetime_to_next_year(datetime: Dictionary):
		var new_datetime = datetime.duplicate(true)
		new_datetime.year = datetime.year + 1
		return new_datetime
	
	static func datetime_to_prev_month(datetime: Dictionary):
		var new_datetime = datetime.duplicate(true)
		new_datetime.day = 1
		if datetime.month == Month.JAN:
			new_datetime.year = datetime.year - 1
			new_datetime.month = Month.DEC
		else:
			new_datetime.year = datetime.year
			new_datetime.month = datetime.month - 1
		return new_datetime
	
	static func datetime_to_next_month(datetime: Dictionary):
		var new_datetime = datetime.duplicate(true)
		new_datetime.day = 1
		if datetime.month == Month.DEC:
			new_datetime.year = datetime.year + 1
			new_datetime.month = Month.JAN
		else:
			new_datetime.year = datetime.year
			new_datetime.month = datetime.month + 1
		return new_datetime
	
	static func datetime_to_prev_day(datetime: Dictionary, prev_days: int=1):
		var timestamp = OS.get_unix_time_from_datetime(datetime)
		timestamp -= prev_days * 86400
		return OS.get_datetime_from_unix_time(timestamp)
	
	static func datetime_to_next_day(datetime: Dictionary, next_days: int=1):
		var timestamp = OS.get_unix_time_from_datetime(datetime)
		timestamp += next_days * 86400
		return OS.get_datetime_from_unix_time(timestamp)
	
	static func datetime_offset_second(datetime: Dictionary, second: int):
		return OS.get_datetime_from_unix_time(OS.get_unix_time_from_datetime(datetime) + second)
	
	static func date_converted_to_first_day_of_month(datetime: Dictionary):
		var new_datetime = datetime.duplicate(true)
		new_datetime.day = 1
		return date_to_datetime(new_datetime)
	
	static func date_string_to_ymd(date_str):
		var ymd = date_str.split(' ')[0].split('-')
		return { "year": int(ymd[0]), "month": int(ymd[1]), "day": int(ymd[2])}
	
	static func datetime_string_to_datetime(datetime_str):
		var ymd = datetime_str.split(' ')[0].split('-')
		var hms = datetime_str.split(' ')[1].split(':')
		return { "year": int(ymd[0]), "month": int(ymd[1]), "day": int(ymd[2]), "hour": int(hms[0]), "minute": int(hms[1]), "second": int(hms[2])}
	
	static func date_string_to_datetime(date_str):
		return date_to_datetime(datetime_string_to_datetime(date_str))
	
	static func date_to_datetime(date: Dictionary):
		return OS.get_datetime_from_unix_time(OS.get_unix_time_from_datetime(date))
	
	static func string_to_timestamp(datetime_str):
		return datetime_to_timestamp(datetime_string_to_datetime(datetime_str))
	
	static func cst_to_unix_timestamp(timestamp: int):
		return timestamp + (3600 * 8)
	
	static func unix_to_cst_timestamp(timestamp: int):
		return timestamp - (3600 * 8)
	
	static func timestamp_to_datetime(timestamp: int, utc: bool = false) -> Dictionary:
		# 检查时间是否需要 utc 时间补齐
		timestamp = cst_to_unix_timestamp(timestamp) if utc else timestamp
		return OS.get_datetime_from_unix_time(timestamp)
	
	static func timestamp_format_MDhm(timestamp: int, utc: bool = false) -> String:
		var date = timestamp_to_datetime(timestamp, utc)
		return "%02d/%02d %02d:%02d" % [date.month, date.day, date.hour, date.minute]
	
	static func timestamp_format_DM(timestamp: int, utc: bool = false) -> String:
		var date = timestamp_to_datetime(timestamp, utc)
		return "%02d/%02d" % [date.day, date.month]
	
	static func timestamp_format_YMD(timestamp: int, utc: bool = false) -> String:
		var date = timestamp_to_datetime(timestamp, utc)
		return "%04d-%02d-%02d" % [date.year, date.month, date.day]
	
	static func timestamp_to_MDhm(timestamp: int, utc: bool = false) -> Array:
		var date = timestamp_to_datetime(timestamp, utc)
		return [date.month, date.day, date.hour, date.minute]
	
	static func datetime_to_timestamp(datetime: Dictionary ) -> int:
		return OS.get_unix_time_from_datetime(datetime)
	
	static func datetime_to_cst_timestamp(datetime: Dictionary) -> int:
		return datetime_to_timestamp(datetime) - (3600 * 8)
	
	static func datetime_to_ymdhms(datetime: Dictionary) -> String:
		return "%04d-%02d-%02d %02d:%02d:%02d" % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second]
