create table site(
    site_name VARCHAR(255) PRIMARY KEY
);

create table commodity(
    com_id INTEGER NOT NULL,
    com_name VARCHAR(255) NOT NULL,
    site_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (site_name) REFERENCES site(site_name),
    PRIMARY KEY(com_id)
);

create table cfg(
    cfg_name VARCHAR(255) PRIMARY KEY,
    com_id INTEGER NOT NULL,
    FOREIGN KEY (com_id) REFERENCES commodity(com_id)
);

create table part(
    part_number VARCHAR(255) PRIMARY KEY,
    cfg_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (cfg_name) REFERENCES cfg(cfg_name)
);

create table forecast(
    cfg_name VARCHAR(255) NOT NULL,
    version_name VARCHAR(255) NOT NULL,
    forecast_type VARCHAR(255) NOT NULL,
    FOREIGN KEY (cfg_name) REFERENCES cfg(cfg_name),
    PRIMARY KEY (cfg_name, version_name)
);

create table week(
    week_id VARCHAR(255) PRIMARY KEY
);

create table entry(
    cfg_name VARCHAR(255) NOT NULL,
    version_name VARCHAR(255) NOT NULL,
    week_id VARCHAR(255) NOT NULL,
    entry_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (cfg_name, version_name) REFERENCES cfg(cfg_name, version_name),
    PRIMARY KEY (cfg_name, version_name, week_id)
);


INSERT INTO site(site_name) VALUES ('NFC');
INSERT INTO site(site_name) VALUES ('LAX');
INSERT INTO site(site_name) VALUES ('FOXJUA');

INSERT INTO site(site)
INSERT INTO commodity(com_id, com_name, site_name) VALUES (1, 'Flat Panel Monitor', 'NFC');

INSERT INTO cfg(cfg_name, com_id) VALUES ('FP_P2217H_WOST_CFG', 1);

INSERT INTO forecast(cfg_name, version_name, forecast_type) VALUES ('FP_P2217H_WOST_CFG', 'FY17Q3W5', 'forecast');

INSERT INTO week(week_id) VALUES ('NovW117');

INSERT INTO entry(cfg_name, version_name, week_id, entry_value) VALUES ('FP_P2217H_WOST_CFG', 'FY17Q3W5', 'NovW117' );


