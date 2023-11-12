/*--
DROP FUNCTION IF EXISTS dbo.GetDiscount;
--*/
GO
CREATE FUNCTION dbo.GetDiscount(@amount DECIMAL(13,2))
RETURNS TABLE
AS
RETURN
  SELECT 0 discount;
