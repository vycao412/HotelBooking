USE [master]
GO
/****** Object:  Database [J3.L.P0012]    Script Date: 12/22/2020 10:41:58 PM ******/
CREATE DATABASE [J3.L.P0012]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'J3.L.P0012', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\J3.L.P0012.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'J3.L.P0012_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\J3.L.P0012_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [J3.L.P0012] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [J3.L.P0012].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [J3.L.P0012] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [J3.L.P0012] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [J3.L.P0012] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [J3.L.P0012] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [J3.L.P0012] SET ARITHABORT OFF 
GO
ALTER DATABASE [J3.L.P0012] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [J3.L.P0012] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [J3.L.P0012] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [J3.L.P0012] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [J3.L.P0012] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [J3.L.P0012] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [J3.L.P0012] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [J3.L.P0012] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [J3.L.P0012] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [J3.L.P0012] SET  DISABLE_BROKER 
GO
ALTER DATABASE [J3.L.P0012] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [J3.L.P0012] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [J3.L.P0012] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [J3.L.P0012] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [J3.L.P0012] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [J3.L.P0012] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [J3.L.P0012] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [J3.L.P0012] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [J3.L.P0012] SET  MULTI_USER 
GO
ALTER DATABASE [J3.L.P0012] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [J3.L.P0012] SET DB_CHAINING OFF 
GO
ALTER DATABASE [J3.L.P0012] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [J3.L.P0012] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [J3.L.P0012] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [J3.L.P0012] SET QUERY_STORE = OFF
GO
USE [J3.L.P0012]
GO
/****** Object:  Table [dbo].[tblBookingDetails]    Script Date: 12/22/2020 10:41:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookingDetails](
	[bdID] [uniqueidentifier] NOT NULL,
	[bdBookingID] [uniqueidentifier] NULL,
	[bRoomType] [uniqueidentifier] NULL,
	[bdQuantity] [int] NULL,
	[bdPrice] [float] NULL,
 CONSTRAINT [PK_tblCategories] PRIMARY KEY CLUSTERED 
(
	[bdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBookings]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBookings](
	[bID] [uniqueidentifier] NOT NULL,
	[bUserID] [varchar](50) NULL,
	[bBookingDate] [date] NOT NULL,
	[bDateFrom] [date] NULL,
	[bDateTo] [date] NULL,
	[bTotal] [float] NULL,
	[bCouponID] [varchar](50) NULL,
	[bFinalTotal] [float] NULL,
	[bStatus] [int] NULL,
 CONSTRAINT [PK_tblBookings] PRIMARY KEY CLUSTERED 
(
	[bID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategories](
	[cID] [uniqueidentifier] NOT NULL,
	[cName] [nvarchar](100) NULL,
 CONSTRAINT [PK_tblCategories_1] PRIMARY KEY CLUSTERED 
(
	[cID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCoupons]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCoupons](
	[cID] [varchar](50) NOT NULL,
	[cName] [nvarchar](100) NULL,
	[cValue] [int] NULL,
	[cCreateDate] [date] NOT NULL,
	[cExpiredDate] [date] NULL,
 CONSTRAINT [PK_tblCoupons] PRIMARY KEY CLUSTERED 
(
	[cID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFeedbacks]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedbacks](
	[fID] [uniqueidentifier] NOT NULL,
	[fRoomType] [uniqueidentifier] NULL,
	[fContent] [nvarchar](max) NULL,
	[fStar] [int] NULL,
	[fUserID] [varchar](50) NULL,
 CONSTRAINT [PK_tblRates] PRIMARY KEY CLUSTERED 
(
	[fID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHotels]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHotels](
	[hID] [uniqueidentifier] NOT NULL,
	[hName] [nvarchar](100) NULL,
	[hAddress] [nvarchar](max) NULL,
	[hPhone] [varchar](20) NULL,
	[hImage] [varchar](100) NULL,
 CONSTRAINT [PK_tblHotels] PRIMARY KEY CLUSTERED 
(
	[hID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[rlID] [int] NOT NULL,
	[rlName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRoles] PRIMARY KEY CLUSTERED 
(
	[rlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoomTypes]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoomTypes](
	[rtID] [uniqueidentifier] NOT NULL,
	[rtHotel] [uniqueidentifier] NULL,
	[rtCategory] [uniqueidentifier] NULL,
	[rtQuantity] [int] NULL,
	[rtPrice] [float] NULL,
	[rtBooking] [int] NOT NULL,
 CONSTRAINT [PK_tblRoomTypes] PRIMARY KEY CLUSTERED 
(
	[rtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStatuses]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatuses](
	[sStatusID] [int] NOT NULL,
	[sName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblStatuses] PRIMARY KEY CLUSTERED 
(
	[sStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[uID] [varchar](50) NOT NULL,
	[uName] [nvarchar](max) NULL,
	[uPassword] [varchar](64) NULL,
	[uPhone] [varchar](20) NULL,
	[uAddress] [nvarchar](max) NULL,
	[uCreateDate] [date] NOT NULL,
	[uStatus] [int] NULL,
	[uRole] [int] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[uID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'eabf9911-238a-456e-8faa-23cf3e8834df', N'701d2563-5ef3-4ce5-b36b-382ab6717e18', N'4eb41b75-eb57-4fc0-b63d-33d39f0b084a', 1, 90)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'934e66da-396e-4f65-8542-2827dc0188cf', N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'e17c81aa-dbc6-43e5-9bd8-1955638abb14', 2, 200)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'258ec356-0f04-40ce-a668-78fed49fda7e', N'701d2563-5ef3-4ce5-b36b-382ab6717e18', N'c74b51fb-9cda-46c4-93ce-598e453f6f61', 1, 80)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'b8c94a20-656e-491c-8e2e-874cc941478a', N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'14bb24a5-1575-4814-8340-cc7bb4a95019', 1, 100)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'64d7fa42-0201-4c02-89a7-b28f820f5d34', N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'e17c81aa-dbc6-43e5-9bd8-1955638abb14', 2, 200)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'9f7ec63d-c6d5-4e05-a506-bf5a0aa422b1', N'701d2563-5ef3-4ce5-b36b-382ab6717e18', N'4fb10aac-1fe2-4ab7-ac62-801561bd244e', 1, 110)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'842ff6dc-961d-4dec-a497-d9622b86d479', N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'c74b51fb-9cda-46c4-93ce-598e453f6f61', 1, 80)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'ab1c93d3-8ce1-4972-910b-e227105f2e9a', N'7c425a43-0ca9-4ac1-bf39-2e96039ce222', N'1b78eabc-7fa6-4eab-a034-65fc3f74fb66', 5, 130)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'd4bc2870-46a2-4015-a5a0-f52883fa513a', N'f18a28fb-0c59-4f92-9f7e-facf3e1c3977', N'cc552269-6648-46a1-81ea-e826e3bd7f5c', 1, 170)
INSERT [dbo].[tblBookingDetails] ([bdID], [bdBookingID], [bRoomType], [bdQuantity], [bdPrice]) VALUES (N'405057e8-8270-4640-b979-fd13306e220a', N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'cc552269-6648-46a1-81ea-e826e3bd7f5c', 1, 170)
GO
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'4ea089d0-4ae3-4b70-a55c-2de894b69e95', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-24' AS Date), CAST(N'2020-12-30' AS Date), 1080, NULL, 1080, 3)
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'7c425a43-0ca9-4ac1-bf39-2e96039ce222', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-22' AS Date), CAST(N'2020-12-23' AS Date), 650, N'NOEL2020', 455, 6)
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'701d2563-5ef3-4ce5-b36b-382ab6717e18', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-23' AS Date), CAST(N'2020-12-30' AS Date), 560, N'NOEL2020', 392, 7)
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'239d0c9c-d401-434b-a30d-5b1de50b01d2', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-24' AS Date), CAST(N'2020-12-30' AS Date), 1200, N'NOEL2020', 840, 3)
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'868ac72e-8e1f-4ba3-ac35-bbd5d396f3c2', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-22' AS Date), CAST(N'2020-12-23' AS Date), 570, NULL, 570, 5)
INSERT [dbo].[tblBookings] ([bID], [bUserID], [bBookingDate], [bDateFrom], [bDateTo], [bTotal], [bCouponID], [bFinalTotal], [bStatus]) VALUES (N'f18a28fb-0c59-4f92-9f7e-facf3e1c3977', N'test', CAST(N'2020-12-22' AS Date), CAST(N'2020-12-22' AS Date), CAST(N'2020-12-23' AS Date), 170, N'NOEL2020', 119, 6)
GO
INSERT [dbo].[tblCategories] ([cID], [cName]) VALUES (N'888e88e9-a46b-4a4d-ba88-88a91dc00c05', N'Double Room')
INSERT [dbo].[tblCategories] ([cID], [cName]) VALUES (N'6a5c8832-1ae1-4b88-9b10-d28e90d981b0', N'Family Room')
INSERT [dbo].[tblCategories] ([cID], [cName]) VALUES (N'6109520e-171d-4c7e-9fd0-fe57b0c36bb9', N'Single Room')
GO
INSERT [dbo].[tblCoupons] ([cID], [cName], [cValue], [cCreateDate], [cExpiredDate]) VALUES (N'NOEL2020', N'Christmas Holiday 2020', 30, CAST(N'2020-12-22' AS Date), CAST(N'2020-12-25' AS Date))
GO
INSERT [dbo].[tblFeedbacks] ([fID], [fRoomType], [fContent], [fStar], [fUserID]) VALUES (N'e6899050-3285-4715-9ac0-059a5201c99c', N'4eb41b75-eb57-4fc0-b63d-33d39f0b084a', N'Great!', 9, N'test')
INSERT [dbo].[tblFeedbacks] ([fID], [fRoomType], [fContent], [fStar], [fUserID]) VALUES (N'd674b697-29bd-4ae0-a689-2d514ba59d86', N'4eb41b75-eb57-4fc0-b63d-33d39f0b084a', N'Great!', 9, N'test')
INSERT [dbo].[tblFeedbacks] ([fID], [fRoomType], [fContent], [fStar], [fUserID]) VALUES (N'99962d86-db70-4527-b5fb-3aed005c319b', N'c74b51fb-9cda-46c4-93ce-598e453f6f61', N'Good!', 10, N'test')
INSERT [dbo].[tblFeedbacks] ([fID], [fRoomType], [fContent], [fStar], [fUserID]) VALUES (N'89a2649a-6465-4b1a-95f7-6df821ec4b4d', N'4eb41b75-eb57-4fc0-b63d-33d39f0b084a', N'Great!', 9, N'test')
GO
INSERT [dbo].[tblHotels] ([hID], [hName], [hAddress], [hPhone], [hImage]) VALUES (N'38a7330a-e179-4bbc-badd-a119c3bd0bdf', N'Pullman SaiGon Centre', N'148 Tran Hung Dao Street, Nguyen Cu Trinh Ward, District 1, HCMC', N'02838388686', N'11815924604_e5e1e1b578_c.jpg')
INSERT [dbo].[tblHotels] ([hID], [hName], [hAddress], [hPhone], [hImage]) VALUES (N'860b86fb-43b2-4add-a599-bc68f324230a', N'Muong Thanh Luxury Hotel Da Nang', N'962 Ngo Quyen Street, An Hai Tay Ward, Son Tra District, Da Nang City', N'02363 929 929', N'502099_14060516240019719334.jpg')
INSERT [dbo].[tblHotels] ([hID], [hName], [hAddress], [hPhone], [hImage]) VALUES (N'd29863f9-e4f4-4a8d-9332-c1168e4b3683', N'Vinpearl Phu Quoc', N'Bai Dai, Ganh Dau Village, Phu Quoc Island, Kien Giang Province', N'0297 377 6555', N'vinpearl-phu-quoc-resort-golf-5819c1438cd8a-848x477.jpg')
INSERT [dbo].[tblHotels] ([hID], [hName], [hAddress], [hPhone], [hImage]) VALUES (N'ac0f8abc-9747-4f5a-b08f-de762c572c5c', N'Rex Hotel SaiGon', N'141 Nguyen Hue Street, Ben Nghe Ward, District 1, HCMC', N'0917590900', N'Feature-rex.jpg')
GO
INSERT [dbo].[tblRoles] ([rlID], [rlName]) VALUES (1, N'Admin')
INSERT [dbo].[tblRoles] ([rlID], [rlName]) VALUES (2, N'Member')
GO
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'e17c81aa-dbc6-43e5-9bd8-1955638abb14', N'ac0f8abc-9747-4f5a-b08f-de762c572c5c', N'6a5c8832-1ae1-4b88-9b10-d28e90d981b0', 10, 200, 2)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'4eb41b75-eb57-4fc0-b63d-33d39f0b084a', N'd29863f9-e4f4-4a8d-9332-c1168e4b3683', N'6109520e-171d-4c7e-9fd0-fe57b0c36bb9', 30, 90, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'c74b51fb-9cda-46c4-93ce-598e453f6f61', N'860b86fb-43b2-4add-a599-bc68f324230a', N'6109520e-171d-4c7e-9fd0-fe57b0c36bb9', 40, 80, 1)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'1b78eabc-7fa6-4eab-a034-65fc3f74fb66', N'd29863f9-e4f4-4a8d-9332-c1168e4b3683', N'6a5c8832-1ae1-4b88-9b10-d28e90d981b0', 20, 130, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'a9c42a42-d3d7-4acd-9cc3-78452071de94', N'ac0f8abc-9747-4f5a-b08f-de762c572c5c', N'6109520e-171d-4c7e-9fd0-fe57b0c36bb9', 15, 150, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'4fb10aac-1fe2-4ab7-ac62-801561bd244e', N'd29863f9-e4f4-4a8d-9332-c1168e4b3683', N'888e88e9-a46b-4a4d-ba88-88a91dc00c05', 15, 110, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'd87ff740-1a37-4101-a64a-8d18112337f4', N'860b86fb-43b2-4add-a599-bc68f324230a', N'6a5c8832-1ae1-4b88-9b10-d28e90d981b0', 20, 150, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'af09b2f6-9ab3-4157-b95c-91b58c323d5f', N'38a7330a-e179-4bbc-badd-a119c3bd0bdf', N'888e88e9-a46b-4a4d-ba88-88a91dc00c05', 24, 200, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'14bb24a5-1575-4814-8340-cc7bb4a95019', N'860b86fb-43b2-4add-a599-bc68f324230a', N'888e88e9-a46b-4a4d-ba88-88a91dc00c05', 25, 100, 1)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'cc552269-6648-46a1-81ea-e826e3bd7f5c', N'38a7330a-e179-4bbc-badd-a119c3bd0bdf', N'6109520e-171d-4c7e-9fd0-fe57b0c36bb9', 25, 170, 1)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'82a49eb0-3dae-4acc-ad92-f0b5e8dc5758', N'ac0f8abc-9747-4f5a-b08f-de762c572c5c', N'888e88e9-a46b-4a4d-ba88-88a91dc00c05', 15, 180, 0)
INSERT [dbo].[tblRoomTypes] ([rtID], [rtHotel], [rtCategory], [rtQuantity], [rtPrice], [rtBooking]) VALUES (N'1c300f83-c42f-456b-81ad-fcf41ffb627b', N'38a7330a-e179-4bbc-badd-a119c3bd0bdf', N'6a5c8832-1ae1-4b88-9b10-d28e90d981b0', 12, 300, 0)
GO
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (1, N'Active')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (2, N'Deactive')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (3, N'Booked')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (4, N'Done Payment')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (5, N'Not yet Payment')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (6, N'Inactive')
INSERT [dbo].[tblStatuses] ([sStatusID], [sName]) VALUES (7, N'Checkout')
GO
INSERT [dbo].[tblUsers] ([uID], [uName], [uPassword], [uPhone], [uAddress], [uCreateDate], [uStatus], [uRole]) VALUES (N'admin', N'Admin', N'ee79976c9380d5e337fc1c095ece8c8f22f91f306ceeb161fa51fecede2c4ba1', N'0303030303', N'HCMC', CAST(N'2020-12-22' AS Date), 1, 1)
INSERT [dbo].[tblUsers] ([uID], [uName], [uPassword], [uPhone], [uAddress], [uCreateDate], [uStatus], [uRole]) VALUES (N'test', N'tester', N'ee79976c9380d5e337fc1c095ece8c8f22f91f306ceeb161fa51fecede2c4ba1', N'0323456789', N'Ho Chi Minh City', CAST(N'2020-12-22' AS Date), 1, 2)
GO
ALTER TABLE [dbo].[tblBookingDetails] ADD  CONSTRAINT [DF_tblBookingDetails_bdID]  DEFAULT (newid()) FOR [bdID]
GO
ALTER TABLE [dbo].[tblBookings] ADD  CONSTRAINT [DF_tblBookings_bID]  DEFAULT (newid()) FOR [bID]
GO
ALTER TABLE [dbo].[tblBookings] ADD  CONSTRAINT [DF_tblBookings_bBookingDate]  DEFAULT (getdate()) FOR [bBookingDate]
GO
ALTER TABLE [dbo].[tblCategories] ADD  CONSTRAINT [DF_tblCategories_cID]  DEFAULT (newid()) FOR [cID]
GO
ALTER TABLE [dbo].[tblCoupons] ADD  CONSTRAINT [DF_tblCoupons_cCreateDate]  DEFAULT (getdate()) FOR [cCreateDate]
GO
ALTER TABLE [dbo].[tblFeedbacks] ADD  CONSTRAINT [DF_tblRates_rID]  DEFAULT (newid()) FOR [fID]
GO
ALTER TABLE [dbo].[tblHotels] ADD  CONSTRAINT [DF_tblHotels_hID]  DEFAULT (newid()) FOR [hID]
GO
ALTER TABLE [dbo].[tblRoomTypes] ADD  CONSTRAINT [DF_tblRoomTypes_rtID]  DEFAULT (newid()) FOR [rtID]
GO
ALTER TABLE [dbo].[tblRoomTypes] ADD  CONSTRAINT [DF_tblRoomTypes_rtBooking]  DEFAULT ((0)) FOR [rtBooking]
GO
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [DF_tblUsers_uCreateDate]  DEFAULT (getdate()) FOR [uCreateDate]
GO
ALTER TABLE [dbo].[tblBookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblBookingDetails_tblBookings] FOREIGN KEY([bdBookingID])
REFERENCES [dbo].[tblBookings] ([bID])
GO
ALTER TABLE [dbo].[tblBookingDetails] CHECK CONSTRAINT [FK_tblBookingDetails_tblBookings]
GO
ALTER TABLE [dbo].[tblBookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblBookingDetails_tblRoomTypes] FOREIGN KEY([bRoomType])
REFERENCES [dbo].[tblRoomTypes] ([rtID])
GO
ALTER TABLE [dbo].[tblBookingDetails] CHECK CONSTRAINT [FK_tblBookingDetails_tblRoomTypes]
GO
ALTER TABLE [dbo].[tblBookings]  WITH CHECK ADD  CONSTRAINT [FK_tblBookings_tblCoupons] FOREIGN KEY([bCouponID])
REFERENCES [dbo].[tblCoupons] ([cID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblBookings] CHECK CONSTRAINT [FK_tblBookings_tblCoupons]
GO
ALTER TABLE [dbo].[tblBookings]  WITH CHECK ADD  CONSTRAINT [FK_tblBookings_tblStatuses] FOREIGN KEY([bStatus])
REFERENCES [dbo].[tblStatuses] ([sStatusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblBookings] CHECK CONSTRAINT [FK_tblBookings_tblStatuses]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblRoomTypes] FOREIGN KEY([fRoomType])
REFERENCES [dbo].[tblRoomTypes] ([rtID])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblRoomTypes]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblUsers] FOREIGN KEY([fUserID])
REFERENCES [dbo].[tblUsers] ([uID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblUsers]
GO
ALTER TABLE [dbo].[tblRoomTypes]  WITH CHECK ADD  CONSTRAINT [FK_tblRoomTypes_tblCategories] FOREIGN KEY([rtCategory])
REFERENCES [dbo].[tblCategories] ([cID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblRoomTypes] CHECK CONSTRAINT [FK_tblRoomTypes_tblCategories]
GO
ALTER TABLE [dbo].[tblRoomTypes]  WITH CHECK ADD  CONSTRAINT [FK_tblRoomTypes_tblHotels] FOREIGN KEY([rtHotel])
REFERENCES [dbo].[tblHotels] ([hID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblRoomTypes] CHECK CONSTRAINT [FK_tblRoomTypes_tblHotels]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblRoles] FOREIGN KEY([uRole])
REFERENCES [dbo].[tblRoles] ([rlID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblRoles]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblStatuses] FOREIGN KEY([uStatus])
REFERENCES [dbo].[tblStatuses] ([sStatusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblStatuses]
GO
/****** Object:  StoredProcedure [dbo].[findAvailableRoom]    Script Date: 12/22/2020 10:41:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[findAvailableRoom]
	@Date DATE
AS
BEGIN
	DECLARE @ID nvarchar(50);
	DECLARE @Amount int;
	UPDATE tblRoomTypes SET rtBooking = 0
	DECLARE myCursor CURSOR FOR 
		SELECT bRoomType, bdQuantity FROM tblBookingDetails
		WHERE bdBookingID IN (
		SELECT bID FROM tblBookings
		WHERE bDateTo > CAST(GETDATE() AS DATE) AND bDateTo > @Date AND (bStatus = 4 OR bStatus = 5)
		)
	OPEN myCursor;
	FETCH NEXT FROM myCursor INTO @ID, @Amount;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE tblRoomTypes SET rtBooking = @Amount WHERE rtID = @ID
		FETCH NEXT FROM myCursor INTO @ID, @Amount;
	END
	CLOSE myCursor;
	DEALLOCATE myCursor;
END



GO
USE [master]
GO
ALTER DATABASE [J3.L.P0012] SET  READ_WRITE 
GO
