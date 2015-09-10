-- insert CTP�����
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertCTPQUOT;
CREATE PROCEDURE procInsertCTPQUOT(IN v_TradingDay varchar(9), 						-- ������
																	 IN v_InstrumentID varchar(31), 				-- ��Լ����
																	 IN	v_ExchangeID varchar(9),						-- ����������
																	 IN	v_ExchangeInstID varchar(31),				-- ��Լ���ڽ������Ĵ���
																	 IN	v_LastPrice double(12,4),						-- ���¼�
																	 IN v_PreSettlementPrice double(12,4),	-- �ϴν����
																	 IN v_PreClosePrice double(12,4),				-- ������
																	 IN v_PreOpenInterest double(12,4),			-- ��ֲ���
																	 IN v_OpenPrice double(12,4),						-- ����
																	 IN v_HighestPrice double(12,4),				-- ��߼�
																	 IN v_LowestPrice double(12,4),					-- ��ͼ�
																	 IN v_Volume bigint(20),								-- ����
																	 IN v_Turnover double(12,4),						-- �ɽ����
																	 IN v_OpenInterest double(12,4),				-- �ֲ���
																	 IN v_ClosePrice double(12,4),					-- ������
																	 IN v_SettlementPrice double(12,4),			-- ���ν����
																	 IN v_UpperLimitPrice double(12,4),			-- ��ͣ���
																	 IN v_LowerLimitPrice double(12,4),			-- ��ͣ���
																	 IN v_PreDelta double(12,4),						-- ����ʵ��
																	 IN v_CurrDelta double(12,4),						-- ����ʵ��
																	 IN v_UpdateTime varchar(9),						-- ����޸�ʱ��
																	 IN v_UpdateMillisec bigint(20),				-- ����޸ĺ���
																	 IN v_BidPrice1 double(12,4),						-- �����һ
																	 IN v_BidVolume1 bigint(20),						-- ������һ
																	 IN v_AskPrice1 double(12,4),						-- ������һ
																	 IN v_AskVolume1 bigint(20),						-- ������һ
																	 IN v_BidPrice2 double(12,4),						-- ����۶�
																	 IN v_BidVolume2 bigint(20),						-- ��������
																	 IN v_AskPrice2 double(12,4),						-- �����۶�
																	 IN v_AskVolume2 bigint(20),						-- ��������
																	 IN v_BidPrice3 double(12,4),						-- �������
																	 IN v_BidVolume3 bigint(20),						-- ��������
																	 IN v_AskPrice3 double(12,4),						-- ��������
																	 IN v_AskVolume3 bigint(20),						-- ��������
																	 IN v_BidPrice4 double(12,4),						-- �������
																	 IN v_BidVolume4 bigint(20),						-- ��������
																	 IN v_AskPrice4 double(12,4),						-- ��������
																	 IN v_AskVolume4 bigint(20),						-- ��������
																	 IN v_BidPrice5 double(12,4),						-- �������
																	 IN v_BidVolume5 bigint(20),						-- ��������
																	 IN v_AskPrice5 double(12,4),						-- ��������
																	 IN v_AskVolume5 bigint(20),						-- ��������
																	 IN v_AveragePrice double(12,4),  			-- ���վ���
																	 IN v_ActionDay varchar(9))							-- ҵ������
BEGIN      
	-- DECLARE sql_insert varchar(1024);
	DECLARE v_VarietyId int;
	set @sTableName = CONCAT('CTPQUOT_',v_InstrumentID);
	-- ���������
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
                   
  -- ����������Ϣ
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
	
	-- ��Լ��Ϣ�Ѵ���
	if exists(select 1 from CONTRACTINFO where InstrumentID=v_InstrumentID) then  
		set v_VarietyId = 0;
	else
		set v_VarietyId = 0;
		-- Ʒ������
		set @varietyName = LEFT(v_InstrumentID,2);
		-- Ʒ��ID
		select VarietyID into v_VarietyId from VARIETYINFO where VarietyName=varietyName;
		-- ������Ʒ����Ϣ
		if v_VarietyId <= 0 then
			-- ����Ʒ����Ϣ
			insert into VARIETYINFO(VarietyName,VarietyStatus,TradeTime)
			values(@varietyName, 1, now());
			-- ���ɵ�Ʒ��ID
			select LAST_INSERT_ID() into v_VarietyId;     
		end if;
		-- �����Լ��Ϣ
		insert into CONTRACTINFO(InstrumentID,ContractStatus,VarietyID)
		values(v_InstrumentID, 1, v_VarietyId);		    
	end if;
	
END $$
DELIMITER ;

-- insert ��½��Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertLoginInfo;
CREATE PROCEDURE procInsertLoginInfo(IN v_UserID bigint(20), 			-- �û�ID
																		 IN v_LoginTime varchar(20),  -- ��¼ʱ��
																		 IN v_LoginIP varchar(20))		-- ��¼IP
BEGIN
	REPLACE INTO LOGININFO(UserID,LoginTime,LoginIP) VALUES(v_UserID,v_LoginTime,v_LoginIP);
END $$
DELIMITER ;

-- insert ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserInfo;
CREATE PROCEDURE procInsertUserInfo(IN v_UserName varchar(512), 	-- �û���
																		IN v_Password varchar(64),		-- ����
																		IN v_RealName varchar(512),		-- ��ʵ����
																		IN v_Mail varchar(250),				-- �ʼ�
																		IN v_Phone varchar(100),			-- �绰
																		OUT v_Uid bigint(20),					-- �û�ID
																		OUT v_Ret int)								-- ִ�н�� 0:�ɹ� 1:�Ѵ���
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

-- update ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procUpdateUserInfo;
CREATE PROCEDURE procUpdateUserInfo(IN v_UserID bigint(20), 			-- �û�ID
																		IN v_Password varchar(64),		-- ����
																		IN v_Mail varchar(250),				-- �ʼ�
																		IN v_Phone varchar(100))			-- �绰
BEGIN
	UPDATE USERINFO SET Password=v_Password,Mail=v_Mail,Phone=v_Phone WHERE UserID=v_UserID;
END $$
DELIMITER ;

-- insert �û����Ա�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserMsg;
CREATE PROCEDURE procInsertUserMsg(IN v_UserID bigint(20), 		-- �û�ID
																	 IN v_Message text,					-- ��������
																	 IN v_Status tinyint(3))		-- ����״̬
BEGIN
	INSERT INTO USERMSG(UserID,MsgTime,Message,Status) VALUES(v_UserID,NOW(),v_Message,v_Status);
END $$
DELIMITER ;

-- insert �����˻���
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertPerAcct;
CREATE PROCEDURE procInsertPerAcct(IN v_UserID bigint(20), 						-- �û�ID
																	 IN v_FundAcct double(12,4),				-- �ʽ��˻�
																	 IN v_CreditAcct double(12,4),			-- �����˻�
																	 IN v_FrozenMoney double(12,4),			-- �����ʽ�
																	 IN v_AvailMoney double(12,4),			-- �����ʽ�
																	 IN v_ManageRevenue double(12,4),		-- �������
																	 IN v_StrategyRevenue double(12,4),	-- ��������
																	 IN v_CurWeekInvest double(12,4),		-- ����Ͷ��
																	 IN v_CurWeekRevenue double(12,4),	-- ��������
																	 IN v_NextWeekInvest double(12,4),	-- ����Ͷ��
																	 IN v_StopLossRate int(11))					-- ֹ�����
BEGIN
	INSERT INTO PERACCT(UserID,FundAcct,CreditAcct,FrozenMoney,AvailMoney,ManageRevenue,
											StrategyRevenue,CurWeekInvest,CurWeekRevenue,NextWeekInvest,StopLossRate) 
	VALUES(v_UserID,v_FundAcct,v_CreditAcct,v_FrozenMoney,v_AvailMoney,v_ManageRevenue,
				 v_StrategyRevenue,v_CurWeekInvest,v_CurWeekRevenue,v_NextWeekInvest,v_StopLossRate);
END $$

-- insert ����ܱ�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertManageWeekChart;
CREATE PROCEDURE procInsertManageWeekChart(IN v_UserID bigint(20), 				-- �û�ID
																					 IN v_Seq int(11),						-- �����
																					 IN v_InvestMoney double(12,4),		-- Ͷ�ʽ��
																					 IN v_ManageRevenue double(12,4),	-- �������
																					 IN v_AnnualYield double(12,4))		-- �껯������
BEGIN
	INSERT INTO MANAGEWEEKCHART(UserID,Seq,InvestMoney,ManageRevenue,AnnualYield,CreateTime) 
	VALUES(v_UserID,v_Seq,v_InvestMoney,v_ManageRevenue,v_AnnualYield,NOW());
END $$
DELIMITER ;

-- insert �����ܱ�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyWeekChart;
CREATE PROCEDURE procInsertStrategyWeekChart(IN v_UserID bigint(20), 						-- �û�ID
																					 	 IN v_Seq int(11),									-- �����
																					 	 IN v_Count int(11),								-- ί������
																					 	 IN v_ManageMoney double(12,4),			-- ������
																					 	 IN v_Yield double(12,4),						-- ������
																					 	 IN v_StrategyRevenue double(12,4))	-- ��������
BEGIN
	INSERT INTO STRATEGYWEEKCHART(UserID,Seq,Count,ManageMoney,Yield,StrategyRevenue,CreateTime) 
	VALUES(v_UserID,v_Seq,v_Count,v_ManageMoney,v_Yield,v_StrategyRevenue,NOW());
END $$
DELIMITER ;

-- insert ƽ̨�˻���
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertSysAcct;
CREATE PROCEDURE procInsertSysAcct(IN v_ACCTID bigint(20), 						-- �˻�ID
																 	 IN v_FundAcct double(12,4),				-- �ʽ��˻�
																 	 IN v_CurWeekRevenue double(12,4))	-- ��������
BEGIN
	INSERT INTO SYSACCT(ACCTID,FundAcct,CurWeekRevenue) 
	VALUES(v_ACCTID,v_FundAcct,v_CurWeekRevenue);
END $$
DELIMITER ;

-- insert ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyInfo;
CREATE PROCEDURE procInsertStrategyInfo(IN v_VarietyID int(11), 					-- Ʒ��ID
																 	 			IN v_StrategyName varchar(512),		-- ������
																 	 			IN v_SubmitterID bigint(20),			-- �����ύ��ID
																 	 			OUT v_StrategyID bigint(20),			-- ����ID
																 	 			OUT v_Ret int)										-- ִ�нṹ 0:���� 1:�������Ѵ���
BEGIN
	DECLARE tempStrategyID bigint(20);
	IF EXISTS(SELECT 1 FROM STRATEGYINFO WHERE SubmitterID=v_SubmitterID AND StrategyName=v_StrategyName) THEN
		-- �������Ѵ���
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

-- update ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procUpdateStrategyInfo;
CREATE PROCEDURE procUpdateStrategyInfo(IN v_StrategyID bigint(20),				-- ����ID
																 	 			IN v_SubmitterID bigint(20),			-- �����ύ��ID
																 	 			IN v_PlanType tinyint(3),					-- �ƻ�����
																 	 			IN v_LongTrendJudge tinyint(3),		-- �����������ж�
																 	 			IN v_ShortTrendJudge tinyint(3),	-- �����������ж�
																 	 			-- IN v_OperaIdea tinyint(3),				-- ����˼·
																 	 			IN v_AnalyMethod tinyint(3),			-- ������ʽ
																 	 			IN v_OperaMethod tinyint(3))			-- ������ʽ
																 	 			-- IN v_SubmitTime int(11),					-- �ύʱ��
																 	 			-- IN v_StrategyStatus tinyint(3))		-- ����״̬
BEGIN
	UPDATE STRATEGYINFO SET PlanType=v_PlanType,LongTrendJudge=v_LongTrendJudge,ShortTrendJudge=v_ShortTrendJudge,AnalyMethod=v_AnalyMethod,OperaMethod=v_OperaMethod,LastModTime=NOW()
	WHERE StrategyID=v_StrategyID AND SubmitterID=v_SubmitterID;
END $$
DELIMITER ;

-- insert ���Գֲ���ϸ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyPosidetail;
CREATE PROCEDURE procInsertStrategyPosidetail(IN v_StrategyID bigint(20), 					-- ����ID
																			 	 			IN v_VarietyID int(11),								-- Ʒ��ID
																			 	 			IN v_ContractID bigint(20),						-- ��ԼID
																			 	 			IN v_OrderNo int(11),									-- �������
																			 	 			IN v_MatchNo int(11),									-- �ɽ����
																			 	 			IN v_BsFlag tinyint(3),								-- ������־
																			 	 			IN v_ShFlag tinyint(3),								-- Ͷ����־
																			 	 			IN v_MatchQty int(11),								-- �ɽ���
																			 	 			IN v_MatchPrice double(12,4),					-- �ɽ��۸�
																			 	 			IN v_StopLossPrice double(12,4),			-- ֹ��۸�
																			 	 			IN v_StopProfitPrice double(12,4))		-- ֹӯ�۸�
BEGIN
	INSERT INTO STRATEGYPOSIDETAIL(StrategyID,VarietyID,ContractID,OrderNo,MatchNo,BsFlag,ShFlag,MatchQty,
													 			 MatchPrice,StopLossPrice,StopProfitPrice) 
	VALUES(v_StrategyID,v_VarietyID,v_ContractID,v_OrderNo,v_MatchNo,v_BsFlag,
				 v_ShFlag,v_MatchQty,v_MatchPrice,v_StopLossPrice,v_StopProfitPrice);
END $$
DELIMITER ;

-- insert ���Զ�����
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyOrder;
CREATE PROCEDURE procInsertStrategyOrder(IN v_UserID bigint(20),							-- �û�ID
																				 IN v_StrategyID bigint(20), 					-- ����ID
																	 	 		 IN v_VarietyID int(11),							-- Ʒ��ID
																	 	 		 IN v_ContractID bigint(20),					-- ��ԼID
																	 	 	   IN v_LocalNo int(11),								-- ����ί�к�
																	 	 	   -- IN v_SysNo int(11),									-- ϵͳί�к�
																	 	 	   -- IN v_OrderNo int(11),								-- �������
																	 	 		 IN v_EfFlag tinyint(3),							-- ��ƽ��־
																	 	 		 IN v_BsFlag tinyint(3),							-- ������־
																	 	 		 -- IN v_ShFlag tinyint(3),							-- Ͷ����־
																	 	 		 IN v_Price double(12,4),							-- �۸�
																	 	 		 IN v_Qty int(11),										-- ����
																	 	 		 IN v_OrderType tinyint(3),						-- �������
																	 	 		 IN v_OrderSort tinyint(3),						-- ��������
																	 	 		 -- IN v_OrderStatus tinyint(3),					-- ί��״̬
																	 	 		 -- IN v_MatchQty int(11),								-- �ɽ�����
																	 	 		 -- IN v_LastPrice double(12,4),					-- ���³ɽ���
																	 	 		 IN v_StopLossPrice double(12,4),			-- ֹ��۸�
																	 	 		 IN v_StopProfitPrice double(12,4),		-- ֹӯ�۸�
																	 	 		 OUT v_OrderNo int(11),								-- �������
																	 	 		 OUT v_MatchDate varchar(20),					-- �ɽ�����
																	 	 		 OUT v_MatchQty int(11),							-- �ɽ���
																	 	 		 OUT v_MatchPrice double(12,4),				-- �ɽ��۸�
																	 	 		 OUT v_Ret int)												-- ִ�н��
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

-- insert ״̬���Ʊ�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStatusCtl;
CREATE PROCEDURE procInsertStatusCtl(IN v_StatusID int(11), 			-- ״̬ID
																	 	 IN v_StatusType tinyint(3),	-- ״̬����
																	 	 IN v_BeginDay varchar(20),		-- ��ʼ��
																	 	 IN v_EndDay varchar(20),			-- ������
																	 	 IN v_BeginTime varchar(20),	-- ��ʼʱ��
																	 	 IN v_EndTime varchar(20))		-- ����ʱ��
BEGIN
	INSERT INTO STATUSCTL(StatusID,StatusType,BeginDay,EndDay,BeginTime,EndTime) 
	VALUES(v_StatusID,v_StatusType,v_BeginDay,v_EndDay,v_BeginTime,v_EndTime);
END $$
DELIMITER ;

-- insert ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategySubInfo;
CREATE PROCEDURE procInsertStrategySubInfo(IN v_StrategyID bigint(20), 	-- ����ID
																				 	 IN v_SubFromID bigint(20),		-- �����û�ID
																				 	 OUT v_Ret int)								-- ִ�н�� 0:�ɹ� 1:�Ѷ���
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

-- insert ���Է�ر�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyRisk;
CREATE PROCEDURE procInsertStrategyRisk(IN v_StrategyID bigint(20), 							-- ����ID
																		 	  IN v_VarietyID int(11),										-- Ʒ��ID
																		 	  IN v_Qty int(11),													-- �ֲ�����
																		 	  IN v_OpenPoint int(11),										-- ���ֵ���
																		 	  IN v_SysStopPoint int(11),								-- ϵͳֹ�����
																		 	  IN v_MinPosi int(11),											-- ��С��λ
																		 	  IN v_MaxPosi int(11),											-- ����λ
																		 	  IN v_AccuWithdrawRange int(11),						-- �ۼƻس�����
																		 	  IN v_TolMoney double(12,4),								-- �ܽ����ʽ�
																		 	  IN v_FloatProfitLossPoint double(12,4),		-- ����ӯ������
																		 	  IN v_CurWeekProfitLossPoint double(12,4),	-- ����ӯ������
																		 	  IN v_AvailStopPoint double(12,4))					-- ����ֹ�����
BEGIN
	INSERT INTO STRATEGYRISK(StrategyID,VarietyID,Qty,OpenPoint,SysStopPoint,MinPosi,MaxPosi,AccuWithdrawRange,
													 TolMoney,FloatProfitLossPoint,CurWeekProfitLossPoint,AvailStopPoint) 
	VALUES(v_StrategyID,v_VarietyID,v_Qty,v_OpenPoint,v_SysStopPoint,v_MinPosi,v_MaxPosi,v_AccuWithdrawRange,
				 v_TolMoney,v_FloatProfitLossPoint,v_CurWeekProfitLossPoint,v_AvailStopPoint);
END $$
DELIMITER ;

-- insert �û�Ͷ�ʲ��Ա�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserStrategy;
CREATE PROCEDURE procInsertUserStrategy(IN v_StrategyID bigint(20), 				-- ����ID
																		 	  IN v_VarietyID int(11),							-- Ʒ��ID
																		 	  IN v_UserID bigint(20),							-- ���Բ�����ID
																		 	  IN v_UserMoney double(12,4),				-- �û�Ͷ���ʽ�
																		 	  IN v_PreStrategyMoney double(12,4),	-- Ͷ��ǰ�������ʽ�
																		 	  IN v_AccuProfit double(12,4),				-- �ۼ�����
																		 	  IN v_CurWeekProfit double(12,4),		-- ��������
																		 	  IN v_CurStatus tinyint(3))					-- ��ǰͶ��״̬
BEGIN
	INSERT INTO USERSTRATEGY(StrategyID,VarietyID,UserID,UserMoney,PreStrategyMoney,AccuProfit,CurWeekProfit,CurStatus) 
	VALUES(v_StrategyID,v_VarietyID,v_UserID,v_UserMoney,v_PreStrategyMoney,v_AccuProfit,v_CurWeekProfit,v_CurStatus);
END $$
DELIMITER ;

-- insert �û�������ϸ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertUserSettleDetail;
CREATE PROCEDURE procInsertUserSettleDetail(IN v_UserID bigint(20), 							-- ���Բ�����ID
																				 	  IN v_StrategyProfit double(12,4),			-- ���Էֳ�
																				 	  IN v_PlatFormProfit double(12,4),			-- ƽ̨�ֳ�
																				 	  IN v_SettleProfitLoss double(12,4),		-- ����ӯ��
																				 	  IN v_InMoney double(12,4),						-- Ͷ���ʽ�
																				 	  IN v_SettleMoney double(12,4),				-- �����ʽ�
																				 	  IN v_PreStrategyMoney double(12,4),		-- Ͷ��ǰ�������ʽ�
																				 	  IN v_SettleTime varchar(20))					-- ����ʱ��
BEGIN
	INSERT INTO USERSETTLEDETAIL(UserID,StrategyProfit,PlatFormProfit,SettleProfitLoss,InMoney,SettleMoney,PreStrategyMoney,SettleTime) 
	VALUES(v_UserID,v_StrategyProfit,v_PlatFormProfit,v_SettleProfitLoss,v_InMoney,v_SettleMoney,v_PreStrategyMoney,v_SettleTime);
END $$
DELIMITER ;

-- insert ����Ԥ�ڶ�����
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertNextWeekAct;
CREATE PROCEDURE procInsertNextWeekAct(IN v_StrategyID bigint(20), 				-- ����ID
																		 	 -- IN v_VarietyID int(11),						-- Ʒ��ID
																		 	 IN v_UserID bigint(20),						-- ���Բ�����ID
																		 	 IN v_InvestType tinyint(3),				-- Ͷ������
																		 	 IN v_MoneyChange double(12,4),			-- �ʽ���
																		 	 OUT v_Ret int)											-- ִ�н��
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
		-- ����ɹ�
		SET v_Ret=0;
	ELSE
		-- Ʒ��ID������
		SET v_Ret=1;
	END IF;
	
END $$
DELIMITER ;

-- insert �û����Գر�
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyPool;
CREATE PROCEDURE procInsertStrategyPool(IN v_UserID bigint(20),						-- ���Բ�����ID
																		 	  IN v_StrategyID bigint(20)) 			-- ����ID
BEGIN
	INSERT INTO STRATEGYPOOL(UserID,StrategyID) VALUES(v_UserID,v_StrategyID);
END $$
DELIMITER ;

-- insert ������ʷ��Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertStrategyHistory;
CREATE PROCEDURE procInsertStrategyHistory(IN v_StrategyID bigint(20), 				-- ����ID
																				 	 IN v_VarietyID int(11),						-- Ʒ��ID
																				 	 IN v_TolMoney double(12,4),				-- �ܽ����ʽ�
																				 	 IN v_TolProfit double(12,4),				-- ������
																				 	 IN v_TolProfitPoint double(12,4),	-- ��������
																				 	 IN v_TradeCount int(11),						-- ���״���
																				 	 IN v_ProfitCount int(11),					-- ӯ������
																				 	 IN v_LossCount int(11),						-- �������
																				 	 IN v_Accuracy double(12,4),				-- ��ȷ��
																				 	 IN v_AvgProfit double(12,4),				-- ƽ������
																				 	 IN v_AvgLoss double(12,4),					-- ƽ������
																				 	 IN v_ProfitFactor double(12,4),		-- ��������
																				 	 IN v_MaxRetracement double(12,4),	-- ���س�
																				 	 IN v_AvgPosiTime int(11),					-- ƽ���ֲ�ʱ��
																				 	 IN v_AnnualYield double(12,4),			-- �껯������
																				 	 IN v_TenWeekATRRate double(12,4),	-- 10��ATR����
																				 	 IN v_TenWeekATRPoint int(11))			-- 10��ATR����
BEGIN
	INSERT INTO STRATEGYHISTORY(StrategyID,VarietyID,TolMoney,TolProfit,TolProfitPoint,TradeCount,
															ProfitCount,LossCount,Accuracy,AvgProfit,AvgLoss,ProfitFactor,MaxRetracement,
															AvgPosiTime,AnnualYield,TenWeekATRRate,TenWeekATRPoint,CreateTime) 
	VALUES(v_StrategyID,v_VarietyID,v_TolMoney,v_TolProfit,v_TolProfitPoint,v_TradeCount,v_ProfitCount,
				 v_LossCount,v_Accuracy,v_AvgProfit,v_AvgLoss,v_ProfitFactor,v_MaxRetracement,v_AvgPosiTime,
				 v_AnnualYield,v_TenWeekATRRate,v_TenWeekATRPoint,NOW());
END $$
DELIMITER ;

-- insert ��ʷ������Ϣ��
DELIMITER $$
DROP PROCEDURE IF EXISTS procInsertTradeHistory;
CREATE PROCEDURE procInsertTradeHistory(IN v_StrategyID bigint(20), 				-- ����ID
																 	 		  IN v_VarietyID int(11),							-- Ʒ��ID
																 	 		  IN v_ContractID bigint(20),					-- ��ԼID
																 	 	    IN v_LocalNo int(11),								-- ����ί�к�
																 	 	    IN v_SysNo int(11),									-- ϵͳί�к�
																 	 	    IN v_OrderNo int(11),								-- �������
																 	 		  IN v_EfFlag tinyint(3),							-- ��ƽ��־
																 	 		  IN v_BsFlag tinyint(3),							-- ������־
																 	 		  IN v_ShFlag tinyint(3),							-- Ͷ����־
																 	 		  IN v_Price double(12,4),						-- �۸�
																 	 		  IN v_Qty int(11),										-- ����
																 	 		  IN v_OrderType tinyint(3),					-- �������
																 	 		  IN v_OrderSort tinyint(3),					-- ��������
																 	 		  IN v_OrderStatus tinyint(3),				-- ί��״̬
																 	 		  IN v_MatchQty int(11),							-- �ɽ�����
																 	 		  IN v_MatchPrice double(12,4),				-- �ɽ���
																 	 		  IN v_StopLossPrice double(12,4),		-- ֹ��۸�
																 	 		  IN v_StopProfitPrice double(12,4)) 	-- ֹӯ�۸�
BEGIN
	INSERT INTO TRADEHISTORY(StrategyID,VarietyID,ContractID,LocalNo,SysNo,OrderNo,EfFlag,BsFlag,
													 ShFlag,Price,Qty,OrderType,OrderSort,OrderStatus,MatchQty,MatchPrice,
													 StopLossPrice,StopProfitPrice) 
	VALUES(v_StrategyID,v_VarietyID,v_ContractID,v_LocalNo,v_SysNo,v_OrderNo,v_EfFlag,v_BsFlag,
				 v_ShFlag,v_Price,v_Qty,v_OrderType,v_OrderSort,v_OrderStatus,v_MatchQty,
				 v_MatchPrice,v_StopLossPrice,v_StopProfitPrice);
END $$
DELIMITER ;