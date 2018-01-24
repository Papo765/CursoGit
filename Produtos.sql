IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelProdutos]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelProdutos]
GO

CREATE PROCEDURE [dbo].[SP_SelProdutos]
	
	AS

	/*Documentação

		Arquivo........: Produto.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Seleciona produtos cadastrado

		Exemplo........: EXEC [dbo].[SP_SelProdutos]

	*/

	BEGIN

		SELECT CodigoProduto, Nome, Preco, Estoque
			FROM [dbo].[Produtos]

	END

GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SelDadosProdutos]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SelDadosProdutos]
GO

CREATE PROCEDURE [dbo].[SelDadosProdutos]
	@CodigoProduto int

	AS

	/*Documentção
		
		Arquivo........: Produto.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Seleciona os dados referente ao produto

		Exemplo........: EXEC [dbo].[SelDadosProdutos] 1

	*/

	BEGIN

		SELECT Nome, Preco, Estoque
			FROM [dbo].[Produto]
			WHERE CodigoProduto = @CodigoProduto

	END

GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_InsProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_InsProduto]
GO

CREATE PROCEDURE [dbo].[SP_InsProduto]
	@Nome varchar(50),
	@Preco decimal(10,2),
	@Estoque smallint

	AS

	/*Documentção
		
		Arquivo........: Produto.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Cadastrar um novo produto
		Retornos.......: 0 = Processamento OK!
						 1 = Falha ao inserir o produto

		Exemplo........: EXEC [dbo].[SP_InsProduto] 'TECLADO', 10.00, 100

	*/

	BEGIN

		INSERT INTO [dbo].[Produtos]
			VALUES(@Nome, @Preco, @Estoque)

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END

GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_UpdProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_UpdProduto]
GO

CREATE PROCEDURE [dbo].[SP_UpdPRoduto]
	@CodigoProduto int,
	@Nome varchar(50),
	@Preco decimal(10, 2),
	@Estoque smallint

	AS

	/*Documentção
		
		Arquivo........: Produto.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Atualizar informações do produto
		Retornos.......: 0 = Processamento OK!
						 1 = Falha ao inserir o produto

		Exemplo........: EXEC [dbo].[SP_UpdProduto] 1, 'MOUSE', 20.01, 100

	*/

	BEGIN
		
		UPDATE [dbo].[Produtos]
			SET Nome = @Nome,
				Preco = @Preco,
				Estoque = @Estoque
			WHERE CodigoProduto = @CodigoProduto

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END
GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_DelProduto]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_DelProduto]
GO

CREATE PROCEDURE [dbo].[SP_DelProduto]
	@CodigoProduto int

	AS

	/*Documentção
		
		Arquivo........: Produto.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Excluir um produto
		Retornos.......: 0 = Processamento OK!
						 1 = Exclusão não permitida, o prodtuo esta vinculada a uma venda
						 2 = Falha ao deletar produto

		Exemplo........: EXEC [dbo].[SP_DelProduto] 1

	*/

	BEGIN

		IF EXISTS(SELECT TOP 1 1 FROM [dbo].[VendaItens] WHERE CodigoProduto = @CodigoProduto)
			RETURN 1  
		
		DELETE FROM [dbo].[Produtos]
			WHERE CodigoProduto = @CodigoProduto

		IF @@ERROR <> 0 OR @@ROWCOUNT = 0
			RETURN 1

		RETURN 0

	END
