-- Write your own SQL object definition here, and it'll be included in your package.
ALTER DATABASE TMS SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE TMS SET ENABLE_BROKER;
-- After enabling the Service Broker, switch it back to multi-user mode:
ALTER DATABASE TMS SET MULTI_USER;