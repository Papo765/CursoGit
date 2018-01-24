IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelCliente]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelCliente]
GO

CREATE PROCEDURE [dbo].[SP_SelCliente]

	AS

		/*Documentção
		
		Arquivo........: Cliente.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 19/01/2018
		Objetivo.......: Seleciona os clientes já cadastrados
		

		Exemplo........: EXEC [dbo].[SP_SelCliente]

		*/

	BEGIN

		SELECT CodigoCLiente, CodigoEndereco, CPF, Nome, Telefone, Email
			FROM [dbo].[Clientes]

	END

GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_SelDadosClientes]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_SelDadosClientes]
GO

CREATE PROCEDURE [dbo].[SP_SelDadosClientes]
	@CodigoCliente int

	AS

		/*Documentção
		
		Arquivo........: Cliente.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 22/01/2018
		Objetivo.......: Seleciona os dados referente a um cliente
		

		Exemplo........: EXEC [dbo].[SelDadosClientes]

		*/

	BEGIN
		
		SELECT c.CodigoCliente, 
			   c.CodigoEndereco,  
			   c.CPF, c.Nome, c.Telefone,
			   c.Email, 
			   c.Numero, 
			   c.Complemento, 
			   e.CodigoEndereco, 
			   e.Cep,
			   e.Logradouro, e.Bairro, e.Cidade, e.UF
			FROM [dbo].[Clientes] AS c
				LEFT OUTER JOIN [dbo].[Enderecos] AS e
					ON c.CodigoEndereco = e.CodigoEndereco
			WHERE c.CodigoCliente = @CodigoCliente
	END	
GO

IF EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[SP_InsClientes]') AND objectproperty(id, N'IsPROCEDURE') = 1)
	DROP PROCEDURE [dbo].[SP_InsClientes]
GO

CREATE PROCEDURE [dbo].[SP_InsClientes]
	@CPF             varchar(14),
	@Nome            varchar(50),
	@Telefone        varchar(15) = NULL,             /*Declaração de Paramentros*/       
	@Email           varchar(50) = NULL,
	@Numero          smallint,
	@Complemento     varchar(30) = NULL,
	@Cep			 int,
	@Logradouro      varchar(50),
	@Bairro			 varchar(30),
	@Cidade          varchar(30),
	@UF              char(2)

	AS

		/*Documentção
		
		Arquivo........: Cliente.sql
		Autor..........: João Paulo Sousa Amesco
		Data...........: 22/01/2018
		Objetivo.......: Insere um novo cliente
		Retorno........: 1 = Falha ao cadastrar o endereço
		

		Exemplo........: EXEC [dbo].[SelDadosClientes] PAssar Parametros aqui

		*/

	BEGIN
		
		DECLARE @CodigoEndereco int

		BEGIN TRANSACTION

			INSERT INTO [dbo].[Enderecos]
				VALUES(@Cep, @Logradouro, @Bairro, @Cidade, @UF)

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				BEGIN
					ROLLBACK TRANSACTION
					RETURN 1
				END

			SET @CodigoEndereco = SCOPE_IDENTITY()

			INSERT INTO [dbo].[Clientes]
				VALUES(@CodigoEndereco, @CPF, @Nome, @Telefone, @Email, @Numero,@Complemento)

			IF @@ERROR <> 0 OR @@ROWCOUNT = 0
				ROLLBACK TRANSACTION
				RETURN 2

		COMMIT TRANSACTION
	END

GO