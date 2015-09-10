-- insert CTP行情表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertCTPQUOT;
CREATE PROCEDURE procInsertCTPQUOT(IN v_TradingDay varchar(9), 						-- 交易日
																	 IN v_InstrumentID varchar(31), 				-- 合约代码
																	 IN	v_ExchangeID varchar(9),						-- 交易所代码
																	 IN	v_ExchangeInstID varchar(31),				-- 合约所在交易所的代码
																	 IN	v_LastPrice double(12,4),						-- 最新价
																	 IN v_PreSettlementPrice double(12,4),	-- 上次结算价
																	 IN v_PreClosePrice double(12,4),				-- 昨收盘
																	 IN v_PreOpenInterest double(12,4),			-- 昨持仓量
																	 IN v_OpenPrice double(12,4),						-- 今开盘
																	 IN v_HighestPrice double(12,4),				-- 最高价
																	 IN v_LowestPrice double(12,4),					-- 最低价
																	 IN v_Volume bigint(20),								-- 数量
																	 IN v_Turnover double(12,4),						-- 成交金额
																	 IN v_OpenInterest double(12,4),				-- 持仓量
																	 IN v_ClosePrice double(12,4),					-- 今收盘
																	 IN v_SettlementPrice double(12,4),			-- 本次结算价
																	 IN v_UpperLimitPrice double(12,4),			-- 涨停板价
																	 IN v_LowerLimitPrice double(12,4),			-- 跌停板价
																	 IN v_PreDelta double(12,4),						-- 昨虚实度
																	 IN v_CurrDelta double(12,4),						-- 今虚实度
																	 IN v_UpdateTime varchar(9),						-- 最后修改时间
																	 IN v_UpdateMillisec bigint(20),				-- 最后修改毫秒
																	 IN v_BidPrice1 double(12,4),						-- 申买价一
																	 IN v_BidVolume1 bigint(20),						-- 申买量一
																	 IN v_AskPrice1 double(12,4),						-- 申卖价一
																	 IN v_AskVolume1 bigint(20),						-- 申卖量一
																	 IN v_BidPrice2 double(12,4),						-- 申买价二
																	 IN v_BidVolume2 bigint(20),						-- 申买量二
																	 IN v_AskPrice2 double(12,4),						-- 申卖价二
																	 IN v_AskVolume2 bigint(20),						-- 申卖量二
																	 IN v_BidPrice3 double(12,4),						-- 申买价三
																	 IN v_BidVolume3 bigint(20),						-- 申买量三
																	 IN v_AskPrice3 double(12,4),						-- 申卖价三
																	 IN v_AskVolume3 bigint(20),						-- 申卖量三
																	 IN v_BidPrice4 double(12,4),						-- 申买价四
																	 IN v_BidVolume4 bigint(20),						-- 申买量四
																	 IN v_AskPrice4 double(12,4),						-- 申卖价四
																	 IN v_AskVolume4 bigint(20),						-- 申卖量四
																	 IN v_BidPrice5 double(12,4),						-- 申买价五
																	 IN v_BidVolume5 bigint(20),						-- 申买量五
																	 IN v_AskPrice5 double(12,4),						-- 申卖价五
																	 IN v_AskVolume5 bigint(20),						-- 申卖量五
																	 IN v_AveragePrice double(12,4),  			-- 当日均价
																	 IN v_ActionDay varchar(9))							-- 业务日期
BEGIN      
	-- DECLARE sql_insert varchar(1024);
	DECLARE v_VarietyId int;
	set @sTableName = CONCAT('CTPQUOT_',v_InstrumentID);
	-- 创建行情表
	set @sql_create_table = CONCAT('CREATE TABLE IF NOT EXISTS ', @sTableName,
	' (ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,                       
	   TradingDay varchar(9),                                                  
	   InstrumentID varchar(31) NOT NULL,                                    
	   ExchangeID varchar(9),                                              
	   ExchangeInstID varchar(31),                               
	   LastPrice double(12,4),                                                 
	   PreSettlementPrice double(12,4),                                    
	   PreClosePrice double(12,4),                                             
	   PreOpenInterest double(12,4),                                         
	   OpenPrice double(12,4),                                                 
	   HighestPrice double(12,4),                                              
	   LowestPrice double(12,4),                                               
	   Volume bigint(20),                                                        
	   Turnover double(12,4),                                                
	   OpenInterest double(12,4),                                              
	   ClosePrice double(12,4),                                                
	   SettlementPrice double(12,4),                                       
	   UpperLimitPrice double(12,4),                                         
	   LowerLimitPrice double(12,4),                                         
	   PreDelta double(12,4),                                                
	   CurrDelta double(12,4),                                               
	   UpdateTime varchar(9),                                            
	   UpdateMillisec bigint(20),                                        
	   BidPrice1 double(12,4),                                               
	   BidVolume1 bigint(20),                                                
     AskPrice1 double(12,4),                                               
     AskVolume1 bigint(20),                                                
     BidPrice2 double(12,4),                                               
     BidVolume2 bigint(20),                                                
     AskPrice2 double(12,4),                                               
     AskVolume2 bigint(20),                                                
     BidPrice3 double(12,4),                                               
     BidVolume3 bigint(20),                                                
     AskPrice3 double(12,4),                                               
     AskVolume3 bigint(20),                                                
     BidPrice4 double(12,4),                                               
     BidVolume4 bigint(20),                                                
     AskPrice4 double(12,4),                                               
     AskVolume4 bigint(20),                                                
     BidPrice5 double(12,4),                                               
     BidVolume5 bigint(20),                                                
     AskPrice5 double(12,4),                                               
     AskVolume5 bigint(20),                                                
     AveragePrice double(12,4),                                            
     ActionDay varchar(9),   
                                                                                           
     PRIMARY KEY (ID),                                                                   
     INDEX (InstrumentID)                                                                
    )ENGINE = MyISAM DEFAULT CHARSET=utf8;');                                    

	PREPARE stmtCreate FROM @sql_create_table;
	EXECUTE stmtCreate;
	DEALLOCATE PREPARE stmtCreate;
                   
  -- 插入行情信息
  set @sql_insert = CONCAT('insert into ',@sTableName,
  '(TradingDay,InstrumentID,ExchangeID,ExchangeInstID,LastPrice,PreSettlementPrice,                                     
	  PreClosePrice,PreOpenInterest,OpenPrice,HighestPrice,LowestPrice,Volume,Turnover,                 
	 	OpenInterest,ClosePrice,SettlementPrice,UpperLimitPrice,LowerLimitPrice,PreDelta,                 
	 	CurrDelta,UpdateTime,UpdateMillisec,BidPrice1,BidVolume1,AskPrice1,AskVolume1,                    
	 	BidPrice2,BidVolume2,AskPrice2,AskVolume2,BidPrice3,BidVolume3,AskPrice3,AskVolume3,BidPrice4,    
	 	BidVolume4,AskPrice4,AskVolume4,BidPrice5,BidVolume5,AskPrice5,AskVolume5,AveragePrice,ActionDay) values(''',
	 	v_TradingDay,'''',',''',v_InstrumentID,'''',',''',v_ExchangeID,'''',',''',v_ExchangeInstID,'''',',',v_LastPrice,',',v_PreSettlementPrice,',',
		v_PreClosePrice,',',v_PreOpenInterest,',',v_OpenPrice,',',v_HighestPrice,',',v_LowestPrice,',',v_Volume,',',v_Turnover,',',
		v_OpenInterest,',',v_ClosePrice,',',v_SettlementPrice,',',v_UpperLimitPrice,',',v_LowerLimitPrice,',',v_PreDelta,',',
		v_CurrDelta,',''',v_UpdateTime,'''',',',v_UpdateMillisec,',',v_BidPrice1,',',v_BidVolume1,',',v_AskPrice1,',',v_AskVolume1,',',
		v_BidPrice2,',',v_BidVolume2,',',v_AskPrice2,',',v_AskVolume2,',',v_BidPrice3,',',v_BidVolume3,',',v_AskPrice3,',',v_AskVolume3,',',v_BidPrice4,',',
		v_BidVolume4,',',v_AskPrice4,',',v_AskVolume4,',',v_BidPrice5,',',v_BidVolume5,',',v_AskPrice5,',',v_AskVolume5,',',v_AveragePrice,',''',v_ActionDay,'''',');');
		
	PREPARE stmtInsert FROM @sql_insert;
	EXECUTE stmtInsert;                       
	DEALLOCATE PREPARE stmtInsert;            
	
	-- 合约信息已存在
	if exists(select 1 from CONTRACTINFO where InstrumentID=v_InstrumentID) then  
		set v_VarietyId = 0;
	else
		set v_VarietyId = 0;
		-- 品种名称
		set @varietyName = LEFT(v_InstrumentID,2);
		-- 品种ID
		select VarietyID into v_VarietyId from VARIETYINFO where VarietyName=varietyName;
		-- 不存在品种信息
		if v_VarietyId <= 0 then
			-- 插入品种信息
			insert into VARIETYINFO(VarietyName,VarietyStatus,TradeTime)
			values(@varietyName, 1, now());
			-- 生成的品种ID
			select LAST_INSERT_ID() into v_VarietyId;     
		end if;
		-- 插入合约信息
		insert into CONTRACTINFO(InstrumentID,ContractStatus,VarietyID)
		values(v_InstrumentID, 1, v_VarietyId);		    
	end if;
	
END $$
DELIMITER ;

-- insert 登陆信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertLoginInfo;
CREATE PROCEDURE procInsertLoginInfo(IN v_UserID bigint(20), 			-- 用户ID
																		 IN v_LoginTime varchar(20),  -- 登录时间
																		 IN v_LoginIP varchar(20))		-- 登录IP
BEGIN
	REPLACE INTO LOGININFO(UserID,LoginTime,LoginIP) VALUES(v_UserID,v_LoginTime,v_LoginIP);
END $$
DELIMITER ;

-- insert 个人信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserInfo;
CREATE PROCEDURE procInsertUserInfo(IN v_UserName varchar(512), 	-- 用户名
																		IN v_Password varchar(64),		-- 密码
																		IN v_RealName varchar(512),		-- 真实姓名
																		IN v_Mail varchar(250),				-- 邮件
																		IN v_Phone varchar(100),			-- 电话
																		OUT v_Uid bigint(20),					-- 用户ID
																		OUT v_Ret int)								-- 执行结果 0:成功 1:已存在
BEGIN
	DECLARE tempUserId bigint(20);
	SELECT UserID INTO tempUserId FROM USERINFO WHERE UserName = v_UserName;
	IF tempUserId > 0 THEN
	set v_Uid = 0;
	set v_Ret = 1;
	ELSE
	INSERT INTO USERINFO(UserName,Password,RealName,Mail,Phone,RegisterTime) 
	VALUES(v_UserName,v_Password,v_RealName,v_Mail,v_Phone,NOW());
	SELECT LAST_INSERT_ID() INTO tempUserId;
	set v_Ret = 0;
	set v_Uid = tempUserId;
	-- CALL procInsertPerAcct(tempUserId,0,0,0,0,0,0,0,0,0,0);	
	END IF;
END $$
DELIMITER ;

-- update 个人信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procUpdateUserInfo;
CREATE PROCEDURE procUpdateUserInfo(IN v_UserID bigint(20), 			-- 用户ID
																		IN v_Password varchar(64),		-- 密码
																		IN v_Mail varchar(250),				-- 邮件
																		IN v_Phone varchar(100))			-- 电话
BEGIN
	UPDATE USERINFO SET Password=v_Password,Mail=v_Mail,Phone=v_Phone WHERE UserID=v_UserID;
END $$
DELIMITER ;

-- insert 用户留言表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserMsg;
CREATE PROCEDURE procInsertUserMsg(IN v_UserID bigint(20), 		-- 用户ID
																	 IN v_Message text,					-- 留言内容
																	 IN v_Status tinyint(3))		-- 留言状态
BEGIN
	INSERT INTO USERMSG(UserID,MsgTime,Message,Status) VALUES(v_UserID,NOW(),v_Message,v_Status);
END $$
DELIMITER ;

-- insert 个人账户表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertPerAcct;
CREATE PROCEDURE procInsertPerAcct(IN v_UserID bigint(20), 						-- 用户ID
																	 IN v_FundAcct double(12,4),				-- 资金账户
																	 IN v_CreditAcct double(12,4),			-- 信用账户
																	 IN v_FrozenMoney double(12,4),			-- 冻结资金
																	 IN v_AvailMoney double(12,4),			-- 可用资金
																	 IN v_ManageRevenue double(12,4),		-- 理财收入
																	 IN v_StrategyRevenue double(12,4),	-- 策略收入
																	 IN v_CurWeekInvest double(12,4),		-- 本周投资
																	 IN v_CurWeekRevenue double(12,4),	-- 本周收入
																	 IN v_NextWeekInvest double(12,4),	-- 下周投资
																	 IN v_StopLossRate int(11))					-- 止损比例
BEGIN
	INSERT INTO PERACCT(UserID,FundAcct,CreditAcct,FrozenMoney,AvailMoney,ManageRevenue,
											StrategyRevenue,CurWeekInvest,CurWeekRevenue,NextWeekInvest,StopLossRate) 
	VALUES(v_UserID,v_FundAcct,v_CreditAcct,v_FrozenMoney,v_AvailMoney,v_ManageRevenue,
				 v_StrategyRevenue,v_CurWeekInvest,v_CurWeekRevenue,v_NextWeekInvest,v_StopLossRate);
END $$

-- insert 理财周表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertManageWeekChart;
CREATE PROCEDURE procInsertManageWeekChart(IN v_UserID bigint(20), 				-- 用户ID
																					 IN v_Seq int(11),						-- 周序号
																					 IN v_InvestMoney double(12,4),		-- 投资金额
																					 IN v_ManageRevenue double(12,4),	-- 理财收入
																					 IN v_AnnualYield double(12,4))		-- 年化收益率
BEGIN
	INSERT INTO MANAGEWEEKCHART(UserID,Seq,InvestMoney,ManageRevenue,AnnualYield,CreateTime) 
	VALUES(v_UserID,v_Seq,v_InvestMoney,v_ManageRevenue,v_AnnualYield,NOW());
END $$
DELIMITER ;

-- insert 策略周表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyWeekChart;
CREATE PROCEDURE procInsertStrategyWeekChart(IN v_UserID bigint(20), 						-- 用户ID
																					 	 IN v_Seq int(11),									-- 周序号
																					 	 IN v_Count int(11),								-- 委托人数
																					 	 IN v_ManageMoney double(12,4),			-- 管理金额
																					 	 IN v_Yield double(12,4),						-- 收益率
																					 	 IN v_StrategyRevenue double(12,4))	-- 策略收入
BEGIN
	INSERT INTO STRATEGYWEEKCHART(UserID,Seq,Count,ManageMoney,Yield,StrategyRevenue,CreateTime) 
	VALUES(v_UserID,v_Seq,v_Count,v_ManageMoney,v_Yield,v_StrategyRevenue,NOW());
END $$
DELIMITER ;

-- insert 平台账户表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertSysAcct;
CREATE PROCEDURE procInsertSysAcct(IN v_ACCTID bigint(20), 						-- 账户ID
																 	 IN v_FundAcct double(12,4),				-- 资金账户
																 	 IN v_CurWeekRevenue double(12,4))	-- 本周收入
BEGIN
	INSERT INTO SYSACCT(ACCTID,FundAcct,CurWeekRevenue) 
	VALUES(v_ACCTID,v_FundAcct,v_CurWeekRevenue);
END $$
DELIMITER ;

-- insert 策略信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyInfo;
CREATE PROCEDURE procInsertStrategyInfo(IN v_VarietyID int(11), 					-- 品种ID
																 	 			IN v_StrategyName varchar(512),		-- 策略名
																 	 			IN v_SubmitterID bigint(20),			-- 策略提交者ID
																 	 			OUT v_StrategyID bigint(20),			-- 策略ID
																 	 			OUT v_Ret int)										-- 执行结构 0:正常 1:策略名已存在
BEGIN
	DECLARE tempStrategyID bigint(20);
	IF EXISTS(SELECT 1 FROM STRATEGYINFO WHERE SubmitterID=v_SubmitterID AND StrategyName=v_StrategyName) THEN
		-- 策略名已存在
		set v_Ret = 1;
	ELSE
		INSERT INTO STRATEGYINFO(VarietyID,StrategyName,SubmitterID,CreateTime,LastModTime) 
		VALUES(v_VarietyID,v_StrategyName,v_SubmitterID,NOW(),NOW());
		SELECT LAST_INSERT_ID() INTO tempStrategyID;
		set v_StrategyID = tempStrategyID;
		set v_Ret = 0; 
	END IF;
END $$
DELIMITER ;

-- update 策略信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procUpdateStrategyInfo;
CREATE PROCEDURE procUpdateStrategyInfo(IN v_StrategyID bigint(20),				-- 策略ID
																 	 			IN v_SubmitterID bigint(20),			-- 策略提交者ID
																 	 			IN v_PlanType tinyint(3),					-- 计划类型
																 	 			IN v_LongTrendJudge tinyint(3),		-- 长周期趋势判断
																 	 			IN v_ShortTrendJudge tinyint(3),	-- 短周期趋势判断
																 	 			-- IN v_OperaIdea tinyint(3),				-- 操作思路
																 	 			IN v_AnalyMethod tinyint(3),			-- 分析方式
																 	 			IN v_OperaMethod tinyint(3))			-- 操作方式
																 	 			-- IN v_SubmitTime int(11),					-- 提交时长
																 	 			-- IN v_StrategyStatus tinyint(3))		-- 策略状态
BEGIN
	UPDATE STRATEGYINFO SET PlanType=v_PlanType,LongTrendJudge=v_LongTrendJudge,ShortTrendJudge=v_ShortTrendJudge,AnalyMethod=v_AnalyMethod,OperaMethod=v_OperaMethod,LastModTime=NOW()
	WHERE StrategyID=v_StrategyID AND SubmitterID=v_SubmitterID;
END $$
DELIMITER ;

-- insert 策略持仓明细表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyPosidetail;
CREATE PROCEDURE procInsertStrategyPosidetail(IN v_StrategyID bigint(20), 					-- 策略ID
																			 	 			IN v_VarietyID int(11),								-- 品种ID
																			 	 			IN v_ContractID bigint(20),						-- 合约ID
																			 	 			IN v_OrderNo int(11),									-- 订单编号
																			 	 			IN v_MatchNo int(11),									-- 成交编号
																			 	 			IN v_BsFlag tinyint(3),								-- 买卖标志
																			 	 			IN v_ShFlag tinyint(3),								-- 投保标志
																			 	 			IN v_MatchQty int(11),								-- 成交量
																			 	 			IN v_MatchPrice double(12,4),					-- 成交价格
																			 	 			IN v_StopLossPrice double(12,4),			-- 止损价格
																			 	 			IN v_StopProfitPrice double(12,4))		-- 止盈价格
BEGIN
	INSERT INTO STRATEGYPOSIDETAIL(StrategyID,VarietyID,ContractID,OrderNo,MatchNo,BsFlag,ShFlag,MatchQty,
													 			 MatchPrice,StopLossPrice,StopProfitPrice) 
	VALUES(v_StrategyID,v_VarietyID,v_ContractID,v_OrderNo,v_MatchNo,v_BsFlag,
				 v_ShFlag,v_MatchQty,v_MatchPrice,v_StopLossPrice,v_StopProfitPrice);
END $$
DELIMITER ;

-- insert 策略订单表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyOrder;
CREATE PROCEDURE procInsertStrategyOrder(IN v_UserID bigint(20),							-- 用户ID
																				 IN v_StrategyID bigint(20), 					-- 策略ID
																	 	 		 IN v_VarietyID int(11),							-- 品种ID
																	 	 		 IN v_ContractID bigint(20),					-- 合约ID
																	 	 	   IN v_LocalNo int(11),								-- 本地委托号
																	 	 	   -- IN v_SysNo int(11),									-- 系统委托号
																	 	 	   -- IN v_OrderNo int(11),								-- 订单编号
																	 	 		 IN v_EfFlag tinyint(3),							-- 开平标志
																	 	 		 IN v_BsFlag tinyint(3),							-- 买卖标志
																	 	 		 -- IN v_ShFlag tinyint(3),							-- 投保标志
																	 	 		 IN v_Price double(12,4),							-- 价格
																	 	 		 IN v_Qty int(11),										-- 数量
																	 	 		 IN v_OrderType tinyint(3),						-- 订单类别
																	 	 		 IN v_OrderSort tinyint(3),						-- 订单类型
																	 	 		 -- IN v_OrderStatus tinyint(3),					-- 委托状态
																	 	 		 -- IN v_MatchQty int(11),								-- 成交数量
																	 	 		 -- IN v_LastPrice double(12,4),					-- 最新成交价
																	 	 		 IN v_StopLossPrice double(12,4),			-- 止损价格
																	 	 		 IN v_StopProfitPrice double(12,4),		-- 止盈价格
																	 	 		 OUT v_OrderNo int(11),								-- 订单编号
																	 	 		 OUT v_MatchDate varchar(20),					-- 成交日期
																	 	 		 OUT v_MatchQty int(11),							-- 成交量
																	 	 		 OUT v_MatchPrice double(12,4),				-- 成交价格
																	 	 		 OUT v_Ret int)												-- 执行结果
BEGIN
	DECLARE tempId int;
	SELECT MAX(ID) INTO tempId FROM STRATEGYORDER;
	IF tempId < 0 THEN
		set tempId = 0;
	END IF;	
	set v_OrderNo = tempId + 1;     
	set v_MatchDate = NOW();
	set v_MatchQty = v_Qty;     
	set v_MatchPrice = v_Price;
	INSERT INTO STRATEGYORDER(StrategyID,VarietyID,ContractID,LocalNo,OrderNo,EfFlag,BsFlag,Price,Qty,OrderType,
													 	OrderSort,MatchDate,MatchQty,LastPrice,StopLossPrice,StopProfitPrice,LastModTime) 
	VALUES(v_StrategyID,v_VarietyID,v_ContractID,v_LocalNo,v_OrderNo,v_EfFlag,v_BsFlag,v_Price,v_Qty,v_OrderType,
				 v_OrderSort,v_MatchDate,v_MatchQty,v_Price,v_StopLossPrice,v_StopProfitPrice,NOW());
	INSERT INTO TRADEHISTORY(UserID,StrategyID,VarietyID,ContractID,LocalNo,OrderNo,EfFlag,BsFlag,Price,Qty,OrderType,                          
													 OrderSort,MatchDate,MatchQty,MatchPrice,StopLossPrice,StopProfitPrice,LastModTime)			 	
	VALUES(v_UserID,v_StrategyID,v_VarietyID,v_ContractID,v_LocalNo,v_OrderNo,v_EfFlag,v_BsFlag,v_Price,v_Qty,v_OrderType,                                
 				 v_OrderSort,v_MatchDate,v_MatchQty,v_Price,v_StopLossPrice,v_StopProfitPrice,NOW());    
 	set v_Ret = 0;   
END $$
DELIMITER ;

-- insert 状态控制表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStatusCtl;
CREATE PROCEDURE procInsertStatusCtl(IN v_StatusID int(11), 			-- 状态ID
																	 	 IN v_StatusType tinyint(3),	-- 状态类型
																	 	 IN v_BeginDay varchar(20),		-- 起始日
																	 	 IN v_EndDay varchar(20),			-- 结束日
																	 	 IN v_BeginTime varchar(20),	-- 起始时刻
																	 	 IN v_EndTime varchar(20))		-- 结束时刻
BEGIN
	INSERT INTO STATUSCTL(StatusID,StatusType,BeginDay,EndDay,BeginTime,EndTime) 
	VALUES(v_StatusID,v_StatusType,v_BeginDay,v_EndDay,v_BeginTime,v_EndTime);
END $$
DELIMITER ;

-- insert 订阅信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategySubInfo;
CREATE PROCEDURE procInsertStrategySubInfo(IN v_StrategyID bigint(20), 	-- 策略ID
																				 	 IN v_SubFromID bigint(20),		-- 订阅用户ID
																				 	 OUT v_Ret int)								-- 执行结果 0:成功 1:已订阅
BEGIN
	IF EXISTS(SELECT 1 FROM STRATEGYSUBINFO WHERE StrategyID=v_StrategyID AND SubFromID=v_SubFromID) THEN
		SELECT SubStatus INTO @subStatus FROM STRATEGYSUBINFO WHERE StrategyID=v_StrategyID AND SubFromID=v_SubFromID;
		set v_Ret = @subStatus;
		IF v_Ret>0 THEN
			set v_Ret = 1;
		ELSE
			UPDATE STRATEGYSUBINFO SET SubStatus=1,BeginTime=NOW(),EndTime=NOW() WHERE StrategyID = v_StrategyID AND SubFromID = v_SubFromID;
			set v_Ret = 0;
		END IF;
	ELSE	
	  INSERT INTO STRATEGYSUBINFO(StrategyID,SubToID,SubFromID,SubStatus,BeginTime,EndTime) VALUES(v_StrategyID,0,v_SubFromID,1,NOW(),NOW());
		set v_Ret = 0;
	END IF;
END $$
DELIMITER ;

-- insert 策略风控表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyRisk;
CREATE PROCEDURE procInsertStrategyRisk(IN v_StrategyID bigint(20), 							-- 策略ID
																		 	  IN v_VarietyID int(11),										-- 品种ID
																		 	  IN v_Qty int(11),													-- 持仓数量
																		 	  IN v_OpenPoint int(11),										-- 开仓点数
																		 	  IN v_SysStopPoint int(11),								-- 系统止损点数
																		 	  IN v_MinPosi int(11),											-- 最小仓位
																		 	  IN v_MaxPosi int(11),											-- 最大仓位
																		 	  IN v_AccuWithdrawRange int(11),						-- 累计回撤幅度
																		 	  IN v_TolMoney double(12,4),								-- 总交易资金
																		 	  IN v_FloatProfitLossPoint double(12,4),		-- 浮动盈亏点数
																		 	  IN v_CurWeekProfitLossPoint double(12,4),	-- 本周盈亏点数
																		 	  IN v_AvailStopPoint double(12,4))					-- 可用止损点数
BEGIN
	INSERT INTO STRATEGYRISK(StrategyID,VarietyID,Qty,OpenPoint,SysStopPoint,MinPosi,MaxPosi,AccuWithdrawRange,
													 TolMoney,FloatProfitLossPoint,CurWeekProfitLossPoint,AvailStopPoint) 
	VALUES(v_StrategyID,v_VarietyID,v_Qty,v_OpenPoint,v_SysStopPoint,v_MinPosi,v_MaxPosi,v_AccuWithdrawRange,
				 v_TolMoney,v_FloatProfitLossPoint,v_CurWeekProfitLossPoint,v_AvailStopPoint);
END $$
DELIMITER ;

-- insert 用户投资策略表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserStrategy;
CREATE PROCEDURE procInsertUserStrategy(IN v_StrategyID bigint(20), 				-- 策略ID
																		 	  IN v_VarietyID int(11),							-- 品种ID
																		 	  IN v_UserID bigint(20),							-- 策略参与者ID
																		 	  IN v_UserMoney double(12,4),				-- 用户投入资金
																		 	  IN v_PreStrategyMoney double(12,4),	-- 投入前策略总资金
																		 	  IN v_AccuProfit double(12,4),				-- 累计收益
																		 	  IN v_CurWeekProfit double(12,4),		-- 本周收益
																		 	  IN v_CurStatus tinyint(3))					-- 当前投资状态
BEGIN
	INSERT INTO USERSTRATEGY(StrategyID,VarietyID,UserID,UserMoney,PreStrategyMoney,AccuProfit,CurWeekProfit,CurStatus) 
	VALUES(v_StrategyID,v_VarietyID,v_UserID,v_UserMoney,v_PreStrategyMoney,v_AccuProfit,v_CurWeekProfit,v_CurStatus);
END $$
DELIMITER ;

-- insert 用户结算明细表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserSettleDetail;
CREATE PROCEDURE procInsertUserSettleDetail(IN v_UserID bigint(20), 							-- 策略参与者ID
																				 	  IN v_StrategyProfit double(12,4),			-- 策略分成
																				 	  IN v_PlatFormProfit double(12,4),			-- 平台分成
																				 	  IN v_SettleProfitLoss double(12,4),		-- 结算盈亏
																				 	  IN v_InMoney double(12,4),						-- 投入资金
																				 	  IN v_SettleMoney double(12,4),				-- 结算资金
																				 	  IN v_PreStrategyMoney double(12,4),		-- 投入前策略总资金
																				 	  IN v_SettleTime varchar(20))					-- 结算时间
BEGIN
	INSERT INTO USERSETTLEDETAIL(UserID,StrategyProfit,PlatFormProfit,SettleProfitLoss,InMoney,SettleMoney,PreStrategyMoney,SettleTime) 
	VALUES(v_UserID,v_StrategyProfit,v_PlatFormProfit,v_SettleProfitLoss,v_InMoney,v_SettleMoney,v_PreStrategyMoney,v_SettleTime);
END $$
DELIMITER ;

-- insert 下周预期动作表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertNextWeekAct;
CREATE PROCEDURE procInsertNextWeekAct(IN v_StrategyID bigint(20), 				-- 策略ID
																		 	 -- IN v_VarietyID int(11),						-- 品种ID
																		 	 IN v_UserID bigint(20),						-- 策略参与者ID
																		 	 IN v_InvestType tinyint(3),				-- 投资类型
																		 	 IN v_MoneyChange double(12,4),			-- 资金量
																		 	 OUT v_Ret int)											-- 执行结果
BEGIN
	DECLARE tempVarietyID int(11);
	SELECT VarietyID INTO tempVarietyID FROM STRATEGYINFO WHERE StrategyID=v_StrategyID;
	IF VarietyID>0 THEN
		IF EXISTS(SELECT 1 FROM NEXTWEEKACT WHERE StrategyID=v_StrategyID AND UserID=v_UserID) THEN
			UPDATE NEXTWEEKACT SET InvestType=v_InvestType,MoneyChange=v_MoneyChange WHERE StrategyID = v_StrategyID AND UserID = v_UserID;
		ELSE
			INSERT INTO NEXTWEEKACT(StrategyID,VarietyID,UserID,InvestType,MoneyChange) 
			VALUES(v_StrategyID,tempVarietyID,v_UserID,v_InvestType,v_MoneyChange);
		END IF;
		-- 插入成功
		SET v_Ret=0;
	ELSE
		-- 品种ID不存在
		SET v_Ret=1;
	END IF;
	
END $$
DELIMITER ;

-- insert 用户策略池表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyPool;
CREATE PROCEDURE procInsertStrategyPool(IN v_UserID bigint(20),						-- 策略参与者ID
																		 	  IN v_StrategyID bigint(20)) 			-- 策略ID
BEGIN
	INSERT INTO STRATEGYPOOL(UserID,StrategyID) VALUES(v_UserID,v_StrategyID);
END $$
DELIMITER ;

-- insert 策略历史信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyHistory;
CREATE PROCEDURE procInsertStrategyHistory(IN v_StrategyID bigint(20), 				-- 策略ID
																				 	 IN v_VarietyID int(11),						-- 品种ID
																				 	 IN v_TolMoney double(12,4),				-- 总交易资金
																				 	 IN v_TolProfit double(12,4),				-- 总收益
																				 	 IN v_TolProfitPoint double(12,4),	-- 点数收益
																				 	 IN v_TradeCount int(11),						-- 交易次数
																				 	 IN v_ProfitCount int(11),					-- 盈利次数
																				 	 IN v_LossCount int(11),						-- 亏损次数
																				 	 IN v_Accuracy double(12,4),				-- 正确率
																				 	 IN v_AvgProfit double(12,4),				-- 平均收益
																				 	 IN v_AvgLoss double(12,4),					-- 平均亏损
																				 	 IN v_ProfitFactor double(12,4),		-- 获利因子
																				 	 IN v_MaxRetracement double(12,4),	-- 最大回撤
																				 	 IN v_AvgPosiTime int(11),					-- 平均持仓时间
																				 	 IN v_AnnualYield double(12,4),			-- 年化收益率
																				 	 IN v_TenWeekATRRate double(12,4),	-- 10周ATR比率
																				 	 IN v_TenWeekATRPoint int(11))			-- 10周ATR点数
BEGIN
	INSERT INTO STRATEGYHISTORY(StrategyID,VarietyID,TolMoney,TolProfit,TolProfitPoint,TradeCount,
															ProfitCount,LossCount,Accuracy,AvgProfit,AvgLoss,ProfitFactor,MaxRetracement,
															AvgPosiTime,AnnualYield,TenWeekATRRate,TenWeekATRPoint,CreateTime) 
	VALUES(v_StrategyID,v_VarietyID,v_TolMoney,v_TolProfit,v_TolProfitPoint,v_TradeCount,v_ProfitCount,
				 v_LossCount,v_Accuracy,v_AvgProfit,v_AvgLoss,v_ProfitFactor,v_MaxRetracement,v_AvgPosiTime,
				 v_AnnualYield,v_TenWeekATRRate,v_TenWeekATRPoint,NOW());
END $$
DELIMITER ;

-- insert 历史交易信息表
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertTradeHistory;
CREATE PROCEDURE procInsertTradeHistory(IN v_StrategyID bigint(20), 				-- 策略ID
																 	 		  IN v_VarietyID int(11),							-- 品种ID
																 	 		  IN v_ContractID bigint(20),					-- 合约ID
																 	 	    IN v_LocalNo int(11),								-- 本地委托号
																 	 	    IN v_SysNo int(11),									-- 系统委托号
																 	 	    IN v_OrderNo int(11),								-- 订单编号
																 	 		  IN v_EfFlag tinyint(3),							-- 开平标志
																 	 		  IN v_BsFlag tinyint(3),							-- 买卖标志
																 	 		  IN v_ShFlag tinyint(3),							-- 投保标志
																 	 		  IN v_Price double(12,4),						-- 价格
																 	 		  IN v_Qty int(11),										-- 数量
																 	 		  IN v_OrderType tinyint(3),					-- 订单类别
																 	 		  IN v_OrderSort tinyint(3),					-- 订单类型
																 	 		  IN v_OrderStatus tinyint(3),				-- 委托状态
																 	 		  IN v_MatchQty int(11),							-- 成交数量
																 	 		  IN v_MatchPrice double(12,4),				-- 成交价
																 	 		  IN v_StopLossPrice double(12,4),		-- 止损价格
																 	 		  IN v_StopProfitPrice double(12,4)) 	-- 止盈价格
BEGIN
	INSERT INTO TRADEHISTORY(StrategyID,VarietyID,ContractID,LocalNo,SysNo,OrderNo,EfFlag,BsFlag,
													 ShFlag,Price,Qty,OrderType,OrderSort,OrderStatus,MatchQty,MatchPrice,
													 StopLossPrice,StopProfitPrice) 
	VALUES(v_StrategyID,v_VarietyID,v_ContractID,v_LocalNo,v_SysNo,v_OrderNo,v_EfFlag,v_BsFlag,
				 v_ShFlag,v_Price,v_Qty,v_OrderType,v_OrderSort,v_OrderStatus,v_MatchQty,
				 v_MatchPrice,v_StopLossPrice,v_StopProfitPrice);
END $$
DELIMITER ;