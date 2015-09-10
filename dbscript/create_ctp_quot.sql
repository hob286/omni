-- 创建CTP行情表
DROP TABLE IF EXISTS CTPQUOT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CTPQUOT` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增序号',
    `TradingDay` varchar(9) COMMENT '交易日',
    `InstrumentID` varchar(31) NOT NULL COMMENT '合约代码',
    `ExchangeID` varchar(9) COMMENT '交易所代码',
    `ExchangeInstID` varchar(31) COMMENT '合约所在交易所的代码',
    `LastPrice` double(12,4) COMMENT '最新价',
    `PreSettlementPrice` double(12,4) COMMENT '上次结算价',
    `PreClosePrice` double(12,4) COMMENT '昨收盘',
    `PreOpenInterest` double(12,4) COMMENT '昨持仓量',
    `OpenPrice` double(12,4) COMMENT '今开盘',
    `HighestPrice` double(12,4) COMMENT '最高价',
    `LowestPrice` double(12,4) COMMENT '最低价',
    `Volume` bigint(20) COMMENT '数量',
    `Turnover` double(12,4) COMMENT '成交金额',
    `OpenInterest` double(12,4) COMMENT '持仓量',
    `ClosePrice` double(12,4) COMMENT '今收盘',
    `SettlementPrice` double(12,4) COMMENT '本次结算价',
    `UpperLimitPrice` double(12,4) COMMENT '涨停板价',
    `LowerLimitPrice` double(12,4) COMMENT '跌停板价',
    `PreDelta` double(12,4) COMMENT '昨虚实度',
    `CurrDelta` double(12,4) COMMENT '今虚实度',
    `UpdateTime` varchar(9) COMMENT '最后修改时间',
    `UpdateMillisec` bigint(20) COMMENT '最后修改毫秒',
    `BidPrice1` double(12,4) COMMENT '申买价一',
    `BidVolume1` bigint(20) COMMENT '申买量一',
    `AskPrice1` double(12,4) COMMENT '申卖价一',
    `AskVolume1` bigint(20) COMMENT '申卖量一',
    `BidPrice2` double(12,4) COMMENT '申买价二',
    `BidVolume2` bigint(20) COMMENT '申买量二',
    `AskPrice2` double(12,4) COMMENT '申卖价二',
    `AskVolume2` bigint(20) COMMENT '申卖量二',
    `BidPrice3` double(12,4) COMMENT '申买价三',
    `BidVolume3` bigint(20) COMMENT '申买量三',
    `AskPrice3` double(12,4) COMMENT '申卖价三',
    `AskVolume3` bigint(20) COMMENT '申卖量三',
    `BidPrice4` double(12,4) COMMENT '申买价四',
    `BidVolume4` bigint(20) COMMENT '申买量四',
    `AskPrice4` double(12,4) COMMENT '申卖价四',
    `AskVolume4` bigint(20) COMMENT '申卖量四',
    `BidPrice5` double(12,4) COMMENT '申买价五',
    `BidVolume5` bigint(20) COMMENT '申买量五',
    `AskPrice5` double(12,4) COMMENT '申卖价五',
    `AskVolume5` bigint(20) COMMENT '申卖量五',
    `AveragePrice` double(12,4) COMMENT '当日均价',
    `ActionDay` varchar(9) COMMENT '业务日期',
    
    PRIMARY KEY (ID),
    INDEX (InstrumentID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建合约信息表
DROP TABLE IF EXISTS CONTRACTINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `CONTRACTINFO` ( 
    `ContractID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '合约ID',
    `InstrumentID` varchar(31) NOT NULL COMMENT '合约代码',
    `ContractStatus`  tinyint(3) unsigned NOT NULL COMMENT '合约状态',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    
    PRIMARY KEY (ContractID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建品种信息表
DROP TABLE IF EXISTS VARIETYINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `VARIETYINFO` ( 
    `VarietyID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '品种ID',
    `VarietyName` varchar(20) NOT NULL COMMENT '品种名',
    `VarietyStatus`  tinyint(3) unsigned NOT NULL COMMENT '品种状态',
    `TradeTime` varchar(128) NOT NULL COMMENT '交易时间',
    
    PRIMARY KEY (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建登陆信息表
DROP TABLE IF EXISTS LOGININFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `LOGININFO` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `LoginTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '登录时间',
    `LoginIP` varchar(20) COMMENT '登录IP',
    `LogoutTime` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT '登出时间',
    
    PRIMARY KEY (UserID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建个人信息表
DROP TABLE IF EXISTS USERINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERINFO` ( 
    `UserID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID 自增',
    `UserName` varchar(512) COMMENT '用户名',
    `Password` varchar(64) COMMENT '密码',
    `RealName` varchar(512) COMMENT '真实姓名',
    `Mail` varchar(250) COMMENT '邮件',
    `Phone` varchar(100) COMMENT '电话',
    `RegisterTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '注册时间',
    
    PRIMARY KEY (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建用户留言表
DROP TABLE IF EXISTS USERMSG;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERMSG` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `MsgTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '留言时间',
    `Message` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '留言内容',
    `Status`  tinyint(3) unsigned NOT NULL COMMENT '留言状态',
    
    PRIMARY KEY (UserID)
)ENGINE = MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建个人账户表
DROP TABLE IF EXISTS PERACCT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `PERACCT` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `FundAcct` double(12,4) COMMENT '资金账户',
    `CreditAcct` double(12,4) COMMENT '信用账户',
    `FrozenMoney` double(12,4) COMMENT '冻结资金',
    `AvailMoney` double(12,4) COMMENT '可用资金',
    `ManageRevenue` double(12,4) COMMENT '理财收入',
    `StrategyRevenue` double(12,4) COMMENT '策略收入',
    `CurWeekInvest` double(12,4) COMMENT '本周投资',
    `CurWeekRevenue` double(12,4) COMMENT '本周收入',
    `NextWeekInvest` double(12,4) COMMENT '下周投资',
    `StopLossRate`  int(11) unsigned NOT NULL COMMENT '止损比例',
    
    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建理财周表
DROP TABLE IF EXISTS MANAGEWEEKCHART;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `MANAGEWEEKCHART` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `Seq`  int(11) unsigned NOT NULL COMMENT '周序号',
    `InvestMoney` double(12,4) COMMENT '投资金额',
    `ManageRevenue` double(12,4) COMMENT '理财收入',
    `AnnualYield` double(12,4) COMMENT '年化收益率',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',

    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略周表
DROP TABLE IF EXISTS STRATEGYWEEKCHART;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYWEEKCHART` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `Seq`  int(11) unsigned NOT NULL COMMENT '周序号',
    `Count`  int(11) unsigned NOT NULL COMMENT '委托人数',
    `ManageMoney` double(12,4) COMMENT '管理金额',
    `Yield` double(12,4) COMMENT '收益率',
    `StrategyRevenue` double(12,4) COMMENT '策略收入',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',

    PRIMARY KEY (UserID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建平台账户表
DROP TABLE IF EXISTS SYSACCT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `SYSACCT` ( 
    `ACCTID` bigint(20) unsigned NOT NULL COMMENT '账户ID',
    `FundAcct` double(12,4) COMMENT '资金账户',
    `CurWeekRevenue` double(12,4) COMMENT '本周收入',
    
    PRIMARY KEY (ACCTID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略信息表
DROP TABLE IF EXISTS STRATEGYINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYINFO` ( 
    `StrategyID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '策略ID 自增',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `StrategyName` varchar(512) COMMENT '策略名',
    `SubmitterID` bigint(20) unsigned NOT NULL COMMENT '策略提交者ID',
    `PlanType`  tinyint(3) unsigned NOT NULL COMMENT '计划类型',
    `LongTrendJudge`  tinyint(3) unsigned NOT NULL COMMENT '长周期趋势判断',
    `ShortTrendJudge`  tinyint(3) unsigned NOT NULL COMMENT '短周期趋势判断',
    `OperaIdea`  tinyint(3) unsigned NOT NULL COMMENT '操作思路',
    `AnalyMethod`  tinyint(3) unsigned NOT NULL COMMENT '分析方式',
    `OperaMethod`  tinyint(3) unsigned NOT NULL COMMENT '操作方式',
    `SubmitTime`  int(11) unsigned  COMMENT '提交时长',
    `StrategyStatus`  tinyint(3) unsigned NOT NULL COMMENT '策略状态',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '最新修改时间',

    PRIMARY KEY (StrategyID),
    INDEX (VarietyID),
    INDEX (SubmitterID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略持仓明细表
DROP TABLE IF EXISTS STRATEGYPOSIDETAIL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYPOSIDETAIL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID 自增',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '合约ID',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '订单编号',
    `MatchNo`  int(11) unsigned NOT NULL COMMENT '成交编号',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '买卖标志',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT '投保标志',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '成交量',
    `MatchPrice` double(12,4) COMMENT '成交价格',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '交易日期',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '成交日期',
    `StopLossPrice` double(12,4) COMMENT '止损价格',
    `StopProfitPrice` double(12,4) COMMENT '止盈价格',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略订单表
DROP TABLE IF EXISTS STRATEGYORDER;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYORDER` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID 自增',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '合约ID',
    `LocalNo`  int(11) unsigned NOT NULL COMMENT '本地委托号',
    `SysNo`  int(11) unsigned NOT NULL COMMENT '系统委托号',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '订单编号',
    `EfFlag`  tinyint(3) unsigned NOT NULL COMMENT '开平标志',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '买卖标志',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT '投保标志',
    `Price` double(12,4) COMMENT '价格',
    `Qty`  int(11) unsigned NOT NULL COMMENT '数量',
    `OrderType`  tinyint(3) unsigned NOT NULL COMMENT '订单类别',
    `OrderSort`  tinyint(3) unsigned NOT NULL COMMENT '订单类型',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '委托时间',
    `OrderStatus`  tinyint(3) unsigned NOT NULL COMMENT '委托状态',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '触发时间',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '成交数量',
    `LastPrice` double(12,4) COMMENT '最新成交价',
    `CancelDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '撤单时间',
    `StopLossPrice` double(12,4) COMMENT '止损价格',
    `StopProfitPrice` double(12,4) COMMENT '止盈价格',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '最后修改时间',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建状态控制表
DROP TABLE IF EXISTS STATUSCTL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STATUSCTL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID 自增',
    `StatusID`  int(11) unsigned NOT NULL COMMENT '状态ID',
    `StatusType`  tinyint(3) unsigned NOT NULL COMMENT '状态类型',
    `BeginDay` timestamp NOT NULL COMMENT '起始日',
    `EndDay` timestamp NOT NULL COMMENT '结束日',
    `BeginTime` timestamp NOT NULL COMMENT '起始时刻',
    `EndTime` timestamp NOT NULL COMMENT '结束时刻',

    PRIMARY KEY (ID),
    INDEX (StatusID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建订阅信息表
DROP TABLE IF EXISTS STRATEGYSUBINFO;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYSUBINFO` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `SubToID` bigint(20) unsigned NOT NULL COMMENT '被订阅用户ID',
    `SubFromID` bigint(20) unsigned NOT NULL COMMENT '订阅用户ID',
    `SubStatus`  tinyint(3) unsigned NOT NULL COMMENT '订阅状态',
    `BeginTime` timestamp NOT NULL COMMENT '订阅开始时间',
    `EndTime` timestamp NOT NULL COMMENT '订阅结束时间',

    PRIMARY KEY (StrategyID),
    INDEX (SubToID),
    INDEX (SubFromID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略风控表
DROP TABLE IF EXISTS STRATEGYRISK;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYRISK` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `Qty`  int(11) unsigned NOT NULL COMMENT '持仓数量',
    `OpenPoint`  int(11) unsigned NOT NULL COMMENT '开仓点数',
    `SysStopPoint`  int(11) unsigned NOT NULL COMMENT '系统止损点数',
    `MinPosi`  int(11) unsigned NOT NULL COMMENT '最小仓位',
    `MaxPosi`  int(11) unsigned NOT NULL COMMENT '最大仓位',
    `AccuWithdrawRange`  int(11) unsigned NOT NULL COMMENT '累计回撤幅度',
    `TolMoney` double(12,4) COMMENT '总交易资金',
    `FloatProfitLossPoint` double(12,4) COMMENT '浮动盈亏点数',
    `CurWeekProfitLossPoint` double(12,4) COMMENT '本周盈亏点数',
    `AvailStopPoint` double(12,4) COMMENT '可用止损点数',

    PRIMARY KEY (StrategyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建用户投资策略表
DROP TABLE IF EXISTS USERSTRATEGY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERSTRATEGY` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '策略参与者ID',
    `UserMoney` double(12,4) COMMENT '用户投入资金',
    `PreStrategyMoney` double(12,4) COMMENT '投入前策略总资金',
    `AccuProfit` double(12,4) COMMENT '累计收益',
    `CurWeekProfit` double(12,4) COMMENT '本周收益',
    `CurStatus`  tinyint(3) unsigned NOT NULL COMMENT '当前投资状态',

    PRIMARY KEY (StrategyID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建用户结算明细表
DROP TABLE IF EXISTS USERSETTLEDETAIL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `USERSETTLEDETAIL` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '策略参与者ID',
    `StrategyProfit` double(12,4) COMMENT '策略分成',
    `PlatFormProfit` double(12,4) COMMENT '平台分成',
    `SettleProfitLoss` double(12,4) COMMENT '结算盈亏',
    `InMoney` double(12,4) COMMENT '投入资金',
    `SettleMoney` double(12,4) COMMENT '结算资金',
    `PreStrategyMoney` double(12,4) COMMENT '投入前策略总资金',
    `SettleTime` timestamp NOT NULL COMMENT '结算时间',

    PRIMARY KEY (ID),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建下周预期动作表
DROP TABLE IF EXISTS NEXTWEEKACT;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `NEXTWEEKACT` ( 
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `UserID` bigint(20) unsigned NOT NULL COMMENT '策略参与者ID',
    `InvestType`  tinyint(3) unsigned NOT NULL COMMENT '投资类型',
    `MoneyChange` double(12,4) NOT NULL COMMENT '资金量',

    PRIMARY KEY (`StrategyID`,`UserID`),
    INDEX (UserID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建用户策略池表
DROP TABLE IF EXISTS STRATEGYPOOL;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYPOOL` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '策略参与者ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',

    PRIMARY KEY (`UserID`,`StrategyID`)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建策略历史信息表
DROP TABLE IF EXISTS STRATEGYHISTORY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `STRATEGYHISTORY` ( 
    `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `TolMoney` double(12,4) COMMENT '总交易资金',
    `TolProfit` double(12,4) COMMENT '总收益',
    `TolProfitPoint` double(12,4) COMMENT '点数收益',
    `TradeCount`  int(11) unsigned NOT NULL COMMENT '交易次数',
    `ProfitCount`  int(11) unsigned NOT NULL COMMENT '盈利次数',
    `LossCount`  int(11) unsigned NOT NULL COMMENT '亏损次数',
    `Accuracy` double(12,4) COMMENT '正确率',
    `AvgProfit` double(12,4) COMMENT '平均收益',
    `AvgLoss` double(12,4) COMMENT '平均亏损',
    `ProfitFactor` double(12,4) COMMENT '获利因子',
    `MaxRetracement` double(12,4) COMMENT '最大回撤',
    `AvgPosiTime`  int(11) unsigned NOT NULL COMMENT '平均持仓时间',
    `AnnualYield` double(12,4) COMMENT '年化收益率',
    `TenWeekATRRate` double(12,4) COMMENT '10周ATR比率',
    `TenWeekATRPoint`  int(11) unsigned NOT NULL COMMENT '10周ATR点数',
    `CreateTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '创建时间',

    PRIMARY KEY (ID),
    INDEX (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

-- 创建历史交易信息表
DROP TABLE IF EXISTS TRADEHISTORY;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `TRADEHISTORY` ( 
    `UserID` bigint(20) unsigned NOT NULL COMMENT '用户ID',
    `StrategyID` bigint(20) unsigned NOT NULL COMMENT '策略ID',
    `VarietyID`  int(11) unsigned NOT NULL COMMENT '品种ID',
    `ContractID` bigint(20) unsigned NOT NULL COMMENT '合约ID',
    `LocalNo`  int(11) unsigned NOT NULL COMMENT '本地委托号',
    `SysNo`  int(11) unsigned NOT NULL COMMENT '系统委托号',
    `OrderNo`  int(11) unsigned NOT NULL COMMENT '订单编号',
    `EfFlag`  tinyint(3) unsigned NOT NULL COMMENT '开平标志',
    `BsFlag`  tinyint(3) unsigned NOT NULL COMMENT '买卖标志',
    `ShFlag`  tinyint(3) unsigned NOT NULL COMMENT '投保标志',
    `Price` double(12,4) COMMENT '价格',
    `Qty`  int(11) unsigned NOT NULL COMMENT '数量',
    `OrderType`  tinyint(3) unsigned NOT NULL COMMENT '订单类别',
    `OrderSort`  tinyint(3) unsigned NOT NULL COMMENT '订单类型',
    `TradeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '委托时间',
    `OrderStatus`  tinyint(3) unsigned NOT NULL COMMENT '委托状态',
    `MatchDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '触发时间',
    `MatchQty`  int(11) unsigned NOT NULL COMMENT '成交数量',
    `MatchPrice` double(12,4) COMMENT '成交价',
    `CancelDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '撤单时间',
    `StopLossPrice` double(12,4) COMMENT '止损价格',
    `StopProfitPrice` double(12,4) COMMENT '止盈价格',
    `LastModTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '最后修改时间',

    PRIMARY KEY (StrategyID),
    INDEX (VarietyID)
)ENGINE = InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;


