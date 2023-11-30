--Creating tables
create table if not exists Areas(
	area_id int PRIMARY KEY,
	area_name text UNIQUE NOT NULL
);

create table if not exists Countries(
	country_id int PRIMARY KEY,
	country_name text UNIQUE NOT NULL
);

create table if not exists Cities(
	city_id bigint PRIMARY KEY,
	city_name text NOT NULL,
	country_id int NOT NULL,
	state text NOT NULL,
	CONSTRAINT fk_country
		FOREIGN KEY(country_id)
			REFERENCES countries(country_id)
	
);

create table if not exists Adresses(
	adress_id bigint PRIMARY KEY,
	city_id bigint NOT NULL,
	street_adress text NOT NULL,
	house_no int NOT NULL,
	zip_code int NOT NULL,
	CONSTRAINT fk_city
		FOREIGN KEY(city_id)
			REFERENCES cities(city_id)
);

create table if not exists Certifications(
	certification_id bigint PRIMARY KEY,
	certification_name text NOT NULL
);

create table if not exists Mountains(
	mountain_id bigint PRIMARY KEY,
	mountain_name text UNIQUE NOT NULL,
	mountain_height int NOT NULL,
	country_id int NOT NULL,
	area_id int NOT NULL,
	CONSTRAINT fk_country
		FOREIGN KEY(country_id)
			REFERENCES countries(country_id),
	CONSTRAINT fk_area
		FOREIGN KEY(area_id)
			REFERENCES areas(area_id),
	CONSTRAINT check_height
		CHECK (mountain_height > 0)
);

create table if not exists Climbers(
	climber_id bigint PRIMARY KEY,
	climber_first_name text UNIQUE NOT NULL,
	climber_last_name text UNIQUE NOT NULL,
	climber_gender text,
	certification_id bigint,
	adress_id int NOT NULL,
	CONSTRAINT fk_certification
		FOREIGN KEY(certification_id)
			REFERENCES certifications(certification_id),
	CONSTRAINT fk_adress
		FOREIGN KEY(adress_id)
			REFERENCES adresses(adress_id),
	CONSTRAINT check_gender
		CHECK (climber_gender in('male', 'female'))
);

create table if not exists Climbings(
	climb_id bigint PRIMARY KEY,
	climber_id bigint NOT NULL,
	mountain_id bigint NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	CONSTRAINT fk_climber
		FOREIGN KEY(climber_id)
			REFERENCES climbers(climber_id),
	CONSTRAINT fk_mountain
		FOREIGN KEY(mountain_id)
			REFERENCES mountains(mountain_id),
	CONSTRAINT check_start_date
		CHECK (start_date > '2000-01-01'),
	CONSTRAINT check_end_date
		CHECK (end_date > '2000-01-01')
);

--Inserting Generated data
insert into areas values(1, 'Europe');
insert into areas values(2, 'Asia');

insert into countries values(1, 'Italy');
insert into countries values(2, 'India');

insert into cities values(1, 'Piedmont', 1, 'Piedmont');
insert into cities values(2, 'New Deli', 2, 'New Deli');

insert into adresses values(1, 1, 'ItalianStreet', 1, 12345);
insert into adresses values(2, 2, 'IdianStreet', 2, 54321);

insert into certifications values(1, 'Climibg sertificate');
insert into certifications values(2, 'Climibg sertificate for climbing mountains');

insert into mountains values(1, 'Marmolada', 3343, 1, 1);
insert into mountains values(2, 'Trisul', 7120, 2, 2);

insert into climbers values(1, 'Bennito', 'Belluchi', 'male', 1, 1);
insert into climbers values(2, 'Ramesh', 'Patel', 'male', 2, 2);

insert into climbings values(1, 1, 1, '2016-02-16', '2016-02-28');
insert into climbings values(2, 2, 2, '2019-06-3', '2019-07-4');

--Adding record_ts to all tables with default value current date
alter table areas add column record_ts date;
update areas
set record_ts = COALESCE(record_ts, current_date);

alter table countries add column record_ts date;
update countries
set record_ts = COALESCE(record_ts, current_date);

alter table cities add column record_ts date;
update cities
set record_ts = COALESCE(record_ts, current_date);

alter table adresses add column record_ts date;
update adresses
set record_ts = COALESCE(record_ts, current_date);

alter table certifications add column record_ts date;
update certifications
set record_ts = COALESCE(record_ts, current_date);

alter table mountains add column record_ts date;
update mountains
set record_ts = COALESCE(record_ts, current_date);

alter table climbers add column record_ts date;
update climbers
set record_ts = COALESCE(record_ts, current_date);

alter table climbings add column record_ts date;
update climbings
set record_ts = COALESCE(record_ts, current_date);

-- select * from areas
-- select * from countries
-- select * from cities
-- select * from adresses
-- select * from certifications
-- select * from mountains
-- select * from climbers
-- select * from climbings

