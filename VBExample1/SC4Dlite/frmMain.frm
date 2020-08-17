VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmMain 
   Caption         =   "Sending Data to SC4Dlite"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   5985
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   5985
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Send to SC4Dlite"
      Height          =   495
      Left            =   2400
      TabIndex        =   2
      Top             =   840
      Width           =   1935
   End
   Begin VB.TextBox txtASCII 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   495
      Left            =   480
      MaxLength       =   4
      TabIndex        =   0
      Top             =   840
      Width           =   1095
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   5160
      Top             =   2400
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label1 
      Caption         =   "Type the characters to be displayed here"
      Height          =   375
      Left            =   360
      TabIndex        =   1
      Top             =   1680
      Width           =   1575
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim uid As Byte     ' Set this variable to SC4Dlite UID

Private Sub Command1_Click()

    Dim s As String
    
    ' Fill up with spaces so that it is always 4 bytes
    
    If Len(txtASCII) < 4 Then
        txtASCII = txtASCII & Space(4 - Len(txtASCII))
    End If
    
    MSComm1.Output = Chr(uid) & "b" & txtASCII  ' Send the Display ASCII command
    
    txtASCII = ""   ' Clear the text

End Sub

Private Sub Form_Load()

    ' Configure Comm Port to 9600,8N1 and Port Number
    MSComm1.Settings = "9600,n,8,1"
    MSComm1.CommPort = 1                ' You may need to change this to match you PC
    MSComm1.PortOpen = True             ' Open Comm Port connection
    ' Set the uid to match the SC4Dlite uid ( 255 default )
    uid = 255

End Sub
