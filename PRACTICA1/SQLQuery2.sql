USE [practica1_1842600]
GO
/****** Object:  Table [dbo].[prueba1]    Script Date: 21/02/2020 09:50:20 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prueba1](
	[columna1] [uniqueidentifier] NOT NULL,
	[columna2] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[columna1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
