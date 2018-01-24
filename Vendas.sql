IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelCliente]
GO

CREATE PROCEDURE [dbo].[SP_SelVendas]

	AS

	BEGIN

		SELECT CodigoVenda, DataVenda,SubTotal, Desconto, Total	
			FROM [dbo].[Vendas]

	END
	
GO

