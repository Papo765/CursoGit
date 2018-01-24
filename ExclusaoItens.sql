CREATE PROCEDURE [dbo].[SP_DelItensVendas]
	@CodigoProduto int,
	@CodigoVenda int

	AS

		/*Document��o
		
		Arquivo........: Produto.sql
		Autor..........: Jo�o Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Excluir um produto
		Retornos.......: 1 = Falha ao excluir um produto

		Exemplo........: EXEC [dbo].[SP_DelItensVendas] 1

		*/

	BEGIN

		DELETE FROM [dbo].[VendaItens] 
			WHERE CodigoProduto = @CodigoProduto,
				  CodigoVenda = @CodigoVenda
				
		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END

GO
	
	