
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/25/2023 18:49:18
-- Generated from EDMX file: C:\Users\ENVY12TH\source\repos\LotteryGameWebAPI\Module\LotteryGameModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [LotteryGameDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_UsersTickets]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_UsersTickets];
GO
IF OBJECT_ID(N'[dbo].[FK_LotteriesTickets]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_LotteriesTickets];
GO
IF OBJECT_ID(N'[dbo].[FK_LotteriesDraws]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Draws] DROP CONSTRAINT [FK_LotteriesDraws];
GO
IF OBJECT_ID(N'[dbo].[FK_DrawsWinners]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Winners] DROP CONSTRAINT [FK_DrawsWinners];
GO
IF OBJECT_ID(N'[dbo].[FK_UsersWinners]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Winners] DROP CONSTRAINT [FK_UsersWinners];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Lotteries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Lotteries];
GO
IF OBJECT_ID(N'[dbo].[Tickets]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tickets];
GO
IF OBJECT_ID(N'[dbo].[Draws]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Draws];
GO
IF OBJECT_ID(N'[dbo].[Winners]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Winners];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [username] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [password_hash] nvarchar(max)  NOT NULL,
    [balance] decimal(18,0)  NOT NULL
);
GO

-- Creating table 'Lotteries'
CREATE TABLE [dbo].[Lotteries] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL,
    [ticket_price] decimal(18,0)  NOT NULL,
    [start_time] datetime  NOT NULL,
    [end_time] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Tickets'
CREATE TABLE [dbo].[Tickets] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [user_id_fk] int  NOT NULL,
    [lottery_id_fk] int  NOT NULL,
    [numbers] smallint  NOT NULL,
    [purchase_time] datetime  NOT NULL,
    [is_winner] bit  NOT NULL,
    [User_Id] int  NOT NULL,
    [Lottery_Id] int  NOT NULL
);
GO

-- Creating table 'Draws'
CREATE TABLE [dbo].[Draws] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [lottery_id_fk] int  NOT NULL,
    [draw_time] datetime  NOT NULL,
    [winning_numbers] smallint  NOT NULL,
    [Lottery_Id] int  NOT NULL
);
GO

-- Creating table 'Winners'
CREATE TABLE [dbo].[Winners] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [draw_id_fk] int  NOT NULL,
    [user_id_fk] int  NOT NULL,
    [prize_amount] decimal(18,0)  NOT NULL,
    [Draw_Id] int  NOT NULL,
    [User_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Lotteries'
ALTER TABLE [dbo].[Lotteries]
ADD CONSTRAINT [PK_Lotteries]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [PK_Tickets]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Draws'
ALTER TABLE [dbo].[Draws]
ADD CONSTRAINT [PK_Draws]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Winners'
ALTER TABLE [dbo].[Winners]
ADD CONSTRAINT [PK_Winners]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [User_Id] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_UsersTickets]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UsersTickets'
CREATE INDEX [IX_FK_UsersTickets]
ON [dbo].[Tickets]
    ([User_Id]);
GO

-- Creating foreign key on [Lottery_Id] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_LotteriesTickets]
    FOREIGN KEY ([Lottery_Id])
    REFERENCES [dbo].[Lotteries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LotteriesTickets'
CREATE INDEX [IX_FK_LotteriesTickets]
ON [dbo].[Tickets]
    ([Lottery_Id]);
GO

-- Creating foreign key on [Lottery_Id] in table 'Draws'
ALTER TABLE [dbo].[Draws]
ADD CONSTRAINT [FK_LotteriesDraws]
    FOREIGN KEY ([Lottery_Id])
    REFERENCES [dbo].[Lotteries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LotteriesDraws'
CREATE INDEX [IX_FK_LotteriesDraws]
ON [dbo].[Draws]
    ([Lottery_Id]);
GO

-- Creating foreign key on [Draw_Id] in table 'Winners'
ALTER TABLE [dbo].[Winners]
ADD CONSTRAINT [FK_DrawsWinners]
    FOREIGN KEY ([Draw_Id])
    REFERENCES [dbo].[Draws]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DrawsWinners'
CREATE INDEX [IX_FK_DrawsWinners]
ON [dbo].[Winners]
    ([Draw_Id]);
GO

-- Creating foreign key on [User_Id] in table 'Winners'
ALTER TABLE [dbo].[Winners]
ADD CONSTRAINT [FK_UsersWinners]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UsersWinners'
CREATE INDEX [IX_FK_UsersWinners]
ON [dbo].[Winners]
    ([User_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------