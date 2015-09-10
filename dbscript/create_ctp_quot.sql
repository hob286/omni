-- ����CTP�����
DROP TABLE IF EXISTS CTPQUOT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CTPQUOT` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '�������',
    `TradingDay` varchar(9) COMMENT '������',
    `InstrumentID` varchar(31) NOT NULL COMMENT '��Լ����',
    `ExchangeID` varchar(9) COMMENT '����������',
    `ExchangeInstID` varchar(31) COMMENT '��Լ���ڽ������Ĵ���',
    `LastPrice` double(12,4) COMMENT '���¼�',
    `PreSettlementPrice` double(12,4) COMMENT '�ϴν����',
    `PreClosePrice` double(12,4) COMMENT '������',
    `PreOpenInterest` double(12,4) COMMENT '��ֲ���',
    `OpenPrice` double(12,4) COMMENT '����',
    `HighestPrice` double(12,4) COMMENT '��߼�',
    `LowestPrice` double(12,4) COMMENT '��ͼ�',
    `Volume` bigint(20) COMMENT '����',
    `Turnover` double(12,4) COMMENT '�ɽ����',
    `OpenInterest` double(12,4) COMMENT '�ֲ���',
    `ClosePrice` double(12,4) COMMENT '������',
    `SettlementPrice` double(12,4) COMMENT '���ν����',
    `UpperLimitPrice` double(12,4) COMMENT '��ͣ���',
    `LowerLimitPrice` double(12,4) COMMENT '��ͣ���',
    `PreDelta` double(12,4) COMMENT '����ʵ��',
    `CurrDelta` double(12,4) COMMENT '����ʵ��',
    `UpdateTime` varchar(9) COMMENT '����޸�ʱ��',
    `UpdateMillisec` bigint(20) COMMENT '����޸ĺ���',
    `BidPrice1` double(12,4) COMMENT '�����һ',
    `BidVolume1` bigint(20) COMMENT '������һ',
    `AskPrice1` double(12,4) COMMENT '������һ',
    `AskVolume1` bigint(20) COMMENT '������һ',
    `BidPrice2` double(12,4) COMMENT '����۶�',
    `BidVolume2` bigint(20) COMMENT '��������',
    `AskPrice2` double(12,4) COMMENT '�����۶�',
    `AskVolume2` bigint(20) COMMENT '��������',
    `BidPrice3` double(12,4) COMMENT '�������',
    `BidVolume3` bigint(20) COMMENT '��������',
    `AskPrice3` double(12,4) COMMENT '��������',
    `AskVolume3` bigint(20) COMMENT '��������',
    `BidPrice4` double(12,4) COMMENT '�������',
    `BidVolume4` bigint(20) COMMENT '��������',
    `AskPrice4` double(12,4) COMMENT '��������',
    `AskVolume4` bigint(20) COMMENT '��������',
    `BidPrice5` double(12,4) COMMENT '�������',
    `BidVolume5` bigint(20) COMMENT '��������',
    `AskPrice5` double(12,4) COMMENT '��������',
    `AskVolume5` bigint(20) COMMENT '��������',
    `AveragePrice` double(12,4) COMMENT '���վ���',
    `ActionDay` varchar(9) COMMENT 'ҵ������',
    
    PRIMARY KEY (ID),
    INDEX (InstrumentID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ������Լ��Ϣ��
DROP TABLE IF EXISTS CONTRACTINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CONTRACTINFO` ( 
    `ContractID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '��ԼID',
    `InstrumentID` varchar(31) NOT NULL COMMENT '��Լ����',
    `ContractStatus`  tinyint(3) unsigned NOT NULL COMMENT '��Լ״̬',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    
    PRIMARY KEY (ContractID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����Ʒ����Ϣ��
DROP TABLE IF EXISTS VARIETYINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `VARIETYINFO` ( 
    `VarietyID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Ʒ��ID',
    `VarietyName` varchar(20) NOT NULL COMMENT 'Ʒ����',
    `VarietyStatus`  tinyint(3) unsigned NOT NULL COMMENT 'Ʒ��״̬',
    `TradeTime` varchar(128) NOT NULL COMMENT '����ʱ��',
    
    PRIMARY KEY (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ������½��Ϣ��
DROP TABLE IF EXISTS LOGININFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `LOGININFO` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `LoginTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '��¼ʱ��',
    `LoginIP` varchar(20) COMMENT '��¼IP',
    `LogoutTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '�ǳ�ʱ��',
    
    PRIMARY KEY (UserID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����������Ϣ��
DROP TABLE IF EXISTS USERINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERINFO` ( 
    `UserID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '�û�ID ����',
    `UserName` varchar(512) COMMENT '�û���',
    `Password` varchar(64) COMMENT '����',
    `RealName` varchar(512) COMMENT '��ʵ����',
    `Mail` varchar(250) COMMENT '�ʼ�',
    `Phone` varchar(100) COMMENT '�绰',
    `RegisterTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT 'ע��ʱ��',
    
    PRIMARY KEY (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �����û����Ա�
DROP TABLE IF EXISTS USERMSG;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERMSG` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `MsgTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `Message` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '��������',
    `Status`  tinyint(3) unsigned NOT NULL COMMENT '����״̬',
    
    PRIMARY KEY (UserID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ���������˻���
DROP TABLE IF EXISTS PERACCT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PERACCT` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `FundAcct` double(12,4) COMMENT '�ʽ��˻�',
    `CreditAcct` double(12,4) COMMENT '�����˻�',
    `FrozenMoney` double(12,4) COMMENT '�����ʽ�',
    `AvailMoney` double(12,4) COMMENT '�����ʽ�',
    `ManageRevenue` double(12,4) COMMENT '�������',
    `StrategyRevenue` double(12,4) COMMENT '��������',
    `CurWeekInvest` double(12,4) COMMENT '����Ͷ��',
    `CurWeekRevenue` double(12,4) COMMENT '��������',
    `NextWeekInvest` double(12,4) COMMENT '����Ͷ��',
    `StopLossRate`  int(11) unsigned NOT NULL COMMENT 'ֹ�����',
    
    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ��������ܱ�
DROP TABLE IF EXISTS MANAGEWEEKCHART;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `MANAGEWEEKCHART` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `Seq`  int(11) unsigned NOT NULL COMMENT '�����',
    `InvestMoney` double(12,4) COMMENT 'Ͷ�ʽ��',
    `ManageRevenue` double(12,4) COMMENT '�������',
    `AnnualYield` double(12,4) COMMENT '�껯������',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',

    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ���������ܱ�
DROP TABLE IF EXISTS STRATEGYWEEKCHART;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYWEEKCHART` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `Seq`  int(11) unsigned NOT NULL COMMENT '�����',
    `Count`  int(11) unsigned NOT NULL COMMENT 'ί������',
    `ManageMoney` double(12,4) COMMENT '������',
    `Yield` double(12,4) COMMENT '������',
    `StrategyRevenue` double(12,4) COMMENT '��������',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',

    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����ƽ̨�˻���
DROP TABLE IF EXISTS SYSACCT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SYSACCT` ( 
    `ACCTID` bigint(20) unsigned NOT NULL COMMENT '�˻�ID',
    `FundAcct` double(12,4) COMMENT '�ʽ��˻�',
    `CurWeekRevenue` double(12,4) COMMENT '��������',
    
    PRIMARY KEY (ACCTID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����������Ϣ��
DROP TABLE IF EXISTS STRATEGYINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYINFO` ( 
    `StrategyID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID ����',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `StrategyName` varchar(512) COMMENT '������',
    `SubmitterID` bigint(20) unsigned NOT NULL COMMENT '�����ύ��ID',
    `PlanType`  tinyint(3) unsigned NOT NULL COMMENT '�ƻ�����',
    `LongTrendJudge`  tinyint(3) unsigned NOT NULL COMMENT '�����������ж�',
    `ShortTrendJudge`  tinyint(3) unsigned NOT NULL COMMENT '�����������ж�',
    `OperaIdea`  tinyint(3) unsigned NOT NULL COMMENT '����˼·',
    `AnalyMethod`  tinyint(3) unsigned NOT NULL COMMENT '������ʽ',
    `OperaMethod`  tinyint(3) unsigned NOT NULL COMMENT '������ʽ',
    `SubmitTime`  int(11) unsigned  COMMENT '�ύʱ��',
    `StrategyStatus`  tinyint(3) unsigned NOT NULL COMMENT '����״̬',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '�����޸�ʱ��',

    PRIMARY KEY (StrategyID),
    INDEX (VarietyID),
    INDEX (SubmitterID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �������Գֲ���ϸ��
DROP TABLE IF EXISTS STRATEGYPOSIDETAIL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYPOSIDETAIL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID ����',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '��ԼID',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '�������',
    `MatchNo`  int(11) unsigned NOT NULL COMMENT '�ɽ����',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '������־',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT 'Ͷ����־',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '�ɽ���',
    `MatchPrice` double(12,4) COMMENT '�ɽ��۸�',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '��������',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '�ɽ�����',
    `StopLossPrice` double(12,4) COMMENT 'ֹ��۸�',
    `StopProfitPrice` double(12,4) COMMENT 'ֹӯ�۸�',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �������Զ�����
DROP TABLE IF EXISTS STRATEGYORDER;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYORDER` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID ����',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '��ԼID',
    `LocalNo`  int(11) unsigned NOT NULL COMMENT '����ί�к�',
    `SysNo`  int(11) unsigned NOT NULL COMMENT 'ϵͳί�к�',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '�������',
    `EfFlag`  tinyint(3) unsigned NOT NULL COMMENT '��ƽ��־',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '������־',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT 'Ͷ����־',
    `Price` double(12,4) COMMENT '�۸�',
    `Qty`  int(11) unsigned NOT NULL COMMENT '����',
    `OrderType`  tinyint(3) unsigned NOT NULL COMMENT '�������',
    `OrderSort`  tinyint(3) unsigned NOT NULL COMMENT '��������',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT 'ί��ʱ��',
    `OrderStatus`  tinyint(3) unsigned NOT NULL COMMENT 'ί��״̬',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '�ɽ�����',
    `LastPrice` double(12,4) COMMENT '���³ɽ���',
    `CancelDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `StopLossPrice` double(12,4) COMMENT 'ֹ��۸�',
    `StopProfitPrice` double(12,4) COMMENT 'ֹӯ�۸�',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����״̬���Ʊ�
DROP TABLE IF EXISTS STATUSCTL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STATUSCTL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID ����',
    `StatusID`  int(11) unsigned NOT NULL COMMENT '״̬ID',
    `StatusType`  tinyint(3) unsigned NOT NULL COMMENT '״̬����',
    `BeginDay` timestamp NOT NULL COMMENT '��ʼ��',
    `EndDay` timestamp NOT NULL COMMENT '������',
    `BeginTime` timestamp NOT NULL COMMENT '��ʼʱ��',
    `EndTime` timestamp NOT NULL COMMENT '����ʱ��',

    PRIMARY KEY (ID),
    INDEX (StatusID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����������Ϣ��
DROP TABLE IF EXISTS STRATEGYSUBINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYSUBINFO` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `SubToID` bigint(20) unsigned NOT NULL COMMENT '�������û�ID',
    `SubFromID` bigint(20) unsigned NOT NULL COMMENT '�����û�ID',
    `SubStatus`  tinyint(3) unsigned NOT NULL COMMENT '����״̬',
    `BeginTime` timestamp NOT NULL COMMENT '���Ŀ�ʼʱ��',
    `EndTime` timestamp NOT NULL COMMENT '���Ľ���ʱ��',

    PRIMARY KEY (StrategyID),
    INDEX (SubToID),
    INDEX (SubFromID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �������Է�ر�
DROP TABLE IF EXISTS STRATEGYRISK;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYRISK` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `Qty`  int(11) unsigned NOT NULL COMMENT '�ֲ�����',
    `OpenPoint`  int(11) unsigned NOT NULL COMMENT '���ֵ���',
    `SysStopPoint`  int(11) unsigned NOT NULL COMMENT 'ϵͳֹ�����',
    `MinPosi`  int(11) unsigned NOT NULL COMMENT '��С��λ',
    `MaxPosi`  int(11) unsigned NOT NULL COMMENT '����λ',
    `AccuWithdrawRange`  int(11) unsigned NOT NULL COMMENT '�ۼƻس�����',
    `TolMoney` double(12,4) COMMENT '�ܽ����ʽ�',
    `FloatProfitLossPoint` double(12,4) COMMENT '����ӯ������',
    `CurWeekProfitLossPoint` double(12,4) COMMENT '����ӯ������',
    `AvailStopPoint` double(12,4) COMMENT '����ֹ�����',

    PRIMARY KEY (StrategyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �����û�Ͷ�ʲ��Ա�
DROP TABLE IF EXISTS USERSTRATEGY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERSTRATEGY` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '���Բ�����ID',
    `UserMoney` double(12,4) COMMENT '�û�Ͷ���ʽ�',
    `PreStrategyMoney` double(12,4) COMMENT 'Ͷ��ǰ�������ʽ�',
    `AccuProfit` double(12,4) COMMENT '�ۼ�����',
    `CurWeekProfit` double(12,4) COMMENT '��������',
    `CurStatus`  tinyint(3) unsigned NOT NULL COMMENT '��ǰͶ��״̬',

    PRIMARY KEY (StrategyID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �����û�������ϸ��
DROP TABLE IF EXISTS USERSETTLEDETAIL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERSETTLEDETAIL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '���Բ�����ID',
    `StrategyProfit` double(12,4) COMMENT '���Էֳ�',
    `PlatFormProfit` double(12,4) COMMENT 'ƽ̨�ֳ�',
    `SettleProfitLoss` double(12,4) COMMENT '����ӯ��',
    `InMoney` double(12,4) COMMENT 'Ͷ���ʽ�',
    `SettleMoney` double(12,4) COMMENT '�����ʽ�',
    `PreStrategyMoney` double(12,4) COMMENT 'Ͷ��ǰ�������ʽ�',
    `SettleTime` timestamp NOT NULL COMMENT '����ʱ��',

    PRIMARY KEY (ID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ��������Ԥ�ڶ�����
DROP TABLE IF EXISTS NEXTWEEKACT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `NEXTWEEKACT` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '���Բ�����ID',
    `InvestType`  tinyint(3) unsigned NOT NULL COMMENT 'Ͷ������',
    `MoneyChange` double(12,4) NOT NULL COMMENT '�ʽ���',

    PRIMARY KEY (`StrategyID`,`UserID`),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- �����û����Գر�
DROP TABLE IF EXISTS STRATEGYPOOL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYPOOL` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '���Բ�����ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',

    PRIMARY KEY (`UserID`,`StrategyID`)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ����������ʷ��Ϣ��
DROP TABLE IF EXISTS STRATEGYHISTORY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYHISTORY` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '����ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `TolMoney` double(12,4) COMMENT '�ܽ����ʽ�',
    `TolProfit` double(12,4) COMMENT '������',
    `TolProfitPoint` double(12,4) COMMENT '��������',
    `TradeCount`  int(11) unsigned NOT NULL COMMENT '���״���',
    `ProfitCount`  int(11) unsigned NOT NULL COMMENT 'ӯ������',
    `LossCount`  int(11) unsigned NOT NULL COMMENT '�������',
    `Accuracy` double(12,4) COMMENT '��ȷ��',
    `AvgProfit` double(12,4) COMMENT 'ƽ������',
    `AvgLoss` double(12,4) COMMENT 'ƽ������',
    `ProfitFactor` double(12,4) COMMENT '��������',
    `MaxRetracement` double(12,4) COMMENT '���س�',
    `AvgPosiTime`  int(11) unsigned NOT NULL COMMENT 'ƽ���ֲ�ʱ��',
    `AnnualYield` double(12,4) COMMENT '�껯������',
    `TenWeekATRRate` double(12,4) COMMENT '10��ATR����',
    `TenWeekATRPoint`  int(11) unsigned NOT NULL COMMENT '10��ATR����',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- ������ʷ������Ϣ��
DROP TABLE IF EXISTS TRADEHISTORY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `TRADEHISTORY` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '�û�ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '����ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT 'Ʒ��ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '��ԼID',
    `LocalNo`  int(11) unsigned NOT NULL COMMENT '����ί�к�',
    `SysNo`  int(11) unsigned NOT NULL COMMENT 'ϵͳί�к�',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '�������',
    `EfFlag`  tinyint(3) unsigned NOT NULL COMMENT '��ƽ��־',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '������־',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT 'Ͷ����־',
    `Price` double(12,4) COMMENT '�۸�',
    `Qty`  int(11) unsigned NOT NULL COMMENT '����',
    `OrderType`  tinyint(3) unsigned NOT NULL COMMENT '�������',
    `OrderSort`  tinyint(3) unsigned NOT NULL COMMENT '��������',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT 'ί��ʱ��',
    `OrderStatus`  tinyint(3) unsigned NOT NULL COMMENT 'ί��״̬',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '�ɽ�����',
    `MatchPrice` double(12,4) COMMENT '�ɽ���',
    `CancelDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����ʱ��',
    `StopLossPrice` double(12,4) COMMENT 'ֹ��۸�',
    `StopProfitPrice` double(12,4) COMMENT 'ֹӯ�۸�',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '����޸�ʱ��',

    PRIMARY KEY (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;


