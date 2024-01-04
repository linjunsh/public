DROP TABLE IF EXISTS hs_satisfaction_sms;

CREATE TABLE public.hs_satisfaction_sms ( 
	id VARCHAR(100) NOT NULL,
    customer_name VARCHAR(50) NOT NULL,  
	mobile_phone VARCHAR(30) NOT NULL,  
	customer_no VARCHAR(30) NOT NULL,  
	nationality VARCHAR(50),  
	gender VARCHAR(10),  
	branch_name VARCHAR(50),  
	rm_code VARCHAR(30),  
	rm_name VARCHAR(30),  
	mdc_type VARCHAR(30),
	mdc_sequence VARCHAR(10),
	survey_code VARCHAR(30),  
	survey_name VARCHAR(50),  
	product_type VARCHAR(50),
	product_name VARCHAR(50),
	product_code VARCHAR(50),  
	transaction_amount NUMERIC(10, 2),  
	currency_type VARCHAR(30),  
	language_code VARCHAR(30),  
	mdc_ext_info VARCHAR(50), 
	create_time TIMESTAMP NOT NULL,  
	ext1 VARCHAR(30),  
	ext2 VARCHAR(30),
	CONSTRAINT hs_satisfaction_sms_pkey PRIMARY KEY (id)		
);

COMMENT ON COLUMN public.hs_satisfaction_sms.id IS '客户ID';
COMMENT ON COLUMN public.hs_satisfaction_sms.customer_name IS '客户姓名';
COMMENT ON COLUMN public.hs_satisfaction_sms.mobile_phone IS '客户手机号码';
COMMENT ON COLUMN public.hs_satisfaction_sms.customer_no IS '客户编号';
COMMENT ON COLUMN public.hs_satisfaction_sms.nationality IS '国籍';
COMMENT ON COLUMN public.hs_satisfaction_sms.gender IS '性别';
COMMENT ON COLUMN public.hs_satisfaction_sms.branch_name IS '分行名称';
COMMENT ON COLUMN public.hs_satisfaction_sms.rm_code IS '客户经理工号';
COMMENT ON COLUMN public.hs_satisfaction_sms.rm_name IS '客户经理姓名';
COMMENT ON COLUMN public.hs_satisfaction_sms.mdc_type IS '短信模板类型，如NPS';
COMMENT ON COLUMN public.hs_satisfaction_sms.mdc_sequence IS '短信模板序号';
COMMENT ON COLUMN public.hs_satisfaction_sms.survey_code IS '问卷触点代码';
COMMENT ON COLUMN public.hs_satisfaction_sms.survey_name IS '问卷触点名称';
COMMENT ON COLUMN public.hs_satisfaction_sms.product_type IS '产品类型';
COMMENT ON COLUMN public.hs_satisfaction_sms.product_name IS '产品名称';
COMMENT ON COLUMN public.hs_satisfaction_sms.product_code IS '产品代码';
COMMENT ON COLUMN public.hs_satisfaction_sms.transaction_amount IS '交易金额';
COMMENT ON COLUMN public.hs_satisfaction_sms.currency_type IS '交易币种';
COMMENT ON COLUMN public.hs_satisfaction_sms.language_code IS '语言';
COMMENT ON COLUMN public.hs_satisfaction_sms.mdc_ext_info IS '短信接口所需字段';
COMMENT ON COLUMN public.hs_satisfaction_sms.create_time IS '创建时间';


DROP TABLE IF EXISTS hs_satisfaction_sms_status;

CREATE TABLE public.hs_satisfaction_sms_status ( 
	id VARCHAR(32) NOT NULL,
    sms_id VARCHAR(100) NOT NULL,  
	mobile_phone VARCHAR(30) NOT NULL, 
	survey_code VARCHAR(30) NOT NULL,  
	status VARCHAR(2),
	create_time TIMESTAMP,  
	send_time TIMESTAMP,
	short_code VARCHAR(30) NOT NULL,
	CONSTRAINT hs_satisfaction_sms_status_pkey PRIMARY KEY (id)		
);

COMMENT ON COLUMN public.hs_satisfaction_sms_status.sms_id IS '短信表ID';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.mobile_phone IS '客户手机号';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.survey_code IS '问卷触点';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.status IS '短信发送状态';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.create_time IS '短信入库时间';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.send_time IS '短信下发MDC时间';
COMMENT ON COLUMN public.hs_satisfaction_sms_status.short_code IS '短码，根据短码获取手机号';


DROP TABLE IF EXISTS hs_satisfaction_sms_token;
CREATE TABLE public.hs_satisfaction_sms_token ( 
	month VARCHAR(6) NOT NULL,
    batch_date VARCHAR(8) NOT NULL,  
	send_time TIMESTAMP NOT NULL,
	send_flag VARCHAR(2),
	t_sv_count VARCHAR(10)	
);

COMMENT ON COLUMN public.hs_satisfaction_sms_token.month IS '当前月份（业务）';
COMMENT ON COLUMN public.hs_satisfaction_sms_token.batch_date IS '批次日期/触点日期';
COMMENT ON COLUMN public.hs_satisfaction_sms_token.send_time IS '数仓完成推送的时间';
COMMENT ON COLUMN public.hs_satisfaction_sms_token.send_flag IS '短信记录发送到DCC成功标识';
COMMENT ON COLUMN public.hs_satisfaction_sms_token.t_sv_count IS '当天需要推送问卷的数据量';


DROP TABLE IF EXISTS hs_satisfaction_sms_token_status;
CREATE TABLE public.hs_satisfaction_sms_token_status ( 
	id VARCHAR(32) NOT NULL,
    batch_data VARCHAR(8) NOT NULL,  
	create_time TIMESTAMP,
	mdc_send_flag VARCHAR(2),
	excl_count VARCHAR(10),
	update_time TIMESTAMP,
	CONSTRAINT hs_satisfaction_sms_token_status_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN public.hs_satisfaction_sms_token_status.batch_data IS '批次日期/触点日期';
COMMENT ON COLUMN public.hs_satisfaction_sms_token_status.create_time IS '短信入库时间';
COMMENT ON COLUMN public.hs_satisfaction_sms_token_status.mdc_send_flag IS '是否已下发MDC';
COMMENT ON COLUMN public.hs_satisfaction_sms_token_status.excl_count IS '短信下发MDC条数';
COMMENT ON COLUMN public.hs_satisfaction_sms_token_status.update_time IS '更新时间';


DROP TABLE IF EXISTS hs_satisfaction_sms_setting;
CREATE TABLE public.hs_satisfaction_sms_setting ( 
	id VARCHAR(32) NOT NULL,
    send_start_time VARCHAR(10) NOT NULL,  
	send_end_time VARCHAR(10) NOT NULL,
	create_time TIMESTAMP,
	update_time TIMESTAMP,
	CONSTRAINT hs_satisfaction_sms_setting_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN public.hs_satisfaction_sms_setting.send_start_time IS '短信发送开始时间';
COMMENT ON COLUMN public.hs_satisfaction_sms_setting.send_end_time IS '短信发送结束时间';

insert into hs_satisfaction_sms_setting(id,send_start_time,send_end_time,create_time,update_time) 
values ('1','20:00','21:00','2023-12-26 12:00:00.000','2023-12-26 12:00:00.000');

alter table t_platform_components_setting add depends_on varchar(50);
alter table t_platform_components_setting add dependent_operator varchar(50);
alter table t_platform_components_setting add dependent_value varchar(100);

alter table t_platform_form add topic_num varchar(10);
alter table t_platform_form add business_type varchar(50);
alter table t_platform_form add short_code varchar(10);


DROP TABLE IF EXISTS hs_satisfaction_business_type;
CREATE TABLE public.hs_satisfaction_business_type ( 
	id VARCHAR(10) NOT NULL,
    code VARCHAR(8) NOT NULL,  
	name VARCHAR(100) NOT NULL,
	create_time TIMESTAMP, 	
	update_time TIMESTAMP
);
COMMENT ON COLUMN public.hs_satisfaction_business_type.code IS '业务编码';
COMMENT ON COLUMN public.hs_satisfaction_business_type.name IS '业务名称';

insert into hs_satisfaction_business_type values ('1','lhkh','来行开户','2023-12-26 12:00:00.000','2023-12-26 12:00:00.000');
insert into hs_satisfaction_business_type values ('2','tzcp','投资产品','2023-12-26 12:00:00.000','2023-12-26 12:00:00.000');
insert into hs_satisfaction_business_type values ('3','bxxd','保险下单','2023-12-26 12:00:00.000','2023-12-26 12:00:00.000');
insert into hs_satisfaction_business_type values ('4','sjqd','手机渠道','2023-12-26 12:00:00.000','2023-12-26 12:00:00.000');


