<!--#include File="adovbs.inc"-->
<%	
	Dim conn
	Dim rs
	Dim currentDBUser
	Dim CDelimiter
	Dim RDelimiter
	
	set conn = Server.CreateObject("ADODB.Connection")	

	CDelimiter = "|!"
	RDelimiter = "|@"
	currentDBUser = ""
	
Sub ConnectDB

	if ( conn.state <> 0 ) and ( currentDBUser <> Application("DBUser") ) then CloseDB
	if ( conn.state = 0 ) then
		
		conn.Open Application("ConnString") , Application("DBUser") , Application("DBPass") 
		conn.BeginTrans
		currentDBUser = Application("DBUser")
		
	end if
	
End Sub

Sub ConnectDBSession

	if ( conn.state <> 0 ) and ( currentDBUser <> Session("DBUser") ) then CloseDB

	if ( conn.state = 0 ) then
	
		conn.Open Application("ConnString") , Session("DBUser") , Session("DBPass") 
		conn.BeginTrans
		currentDBUser = Session("DBUser")
	end if
	
End Sub


Sub ConnectDBUserPass( user , pass )

	if ( conn.state <> 0 ) and ( currentDBUser <> user ) then CloseDB
	
	if ( conn.state = 0 ) then
	
		conn.Open "Provider=MSDAORA;Data Source=esys" , user  , pass 
		conn.BeginTrans
		currentDBUser = user
	end if
	
End Sub


Sub CloseDB
	conn.CommitTrans
	conn.close	
End Sub

Sub CloseRollbackDB
	conn.RollbackTrans 
	conn.close	
End Sub

Sub TableReadOpen( rs, command )

	set rs = Server.CreateObject("ADODB.Recordset")	
	rs.CursorType = adOpenStatic
	rs.LockType = adLockReadOnly
	rs.ActiveConnection = conn
	rs.Source = command

	rs.Open

End Sub


Sub TableUpdateOpen ( rs, command )

	set rs = Server.CreateObject("ADODB.Recordset")	
	rs.CursorType = adOpenKeyset
	rs.LockType = adLockOptimistic
	rs.ActiveConnection = conn
	rs.Source = command

	
	if ( Application("Oracle") ) then
		rs.CursorLocation = adUseClient
	end if
	rs.Open

End Sub

Function GetNewID()

	Application.Lock
	
	GetNewID = GetNewID2()
	
	Application.Unlock
End Function 	

Function GetNewIDBySeq( table )
	Dim rs

	'
	' When binary file is uploaded, Error  
	'
	' response.write "<======pk======>"
	' response.write "Table Name ==>[" & table & "]"
	
	TableReadOpen rs , "select " & table & "_seq.nextval from dual" 
	
	'  response.write "pk==>[" & rs(0) & "]"
		
	GetNewIDBySeq = rs(0)
	rs.Close

End Function
	
	
Function GetNewID2()

	GetNewID2 = Application("ID") 
	Application("ID") = Application("ID") + 1
	
	
	if ( Application("ID") >=  Application("LastID") )  then
		Dim rs
			
		Application("LastID") = Application("ID") + 50
	
		conn.Execute( "update " & SysTable("IDGEN") & " set id = " & Application("LastID") )
	end if
	
End Function 	


Function GetDateString( d )

	GetDateString = Right( "000" + CStr(Year( d )) , 4 ) + 	Right( "0" + CStr( Month( d ) ) , 2 ) + 	Right(  "0" + CStr(Day( d ) ), 2 )
	
End Function

	
Function DelDateDelimiter( d )
	DelDateDelimiter = left( d , 4 ) + mid( d , 6, 2) + right(d,2)
End Function

Function AddDateDelimiter( d )

	if ( d = "99999999" or d="00000000") then
		AddDateDelimiter = "(Progressing)"
	else
		if ( len(d) > 0 ) then
			AddDateDelimiter = Left( d , 4 ) + "/" + Mid( d, 5, 2 ) +"/" + Right( d, 2 )
		else
			AddDateDelimiter = ""
		end if
	end if
	
End Function


	Sub TreeViewEmpty ()
	%>
		<div oid="-1" > </div>
	<%
	End Sub

	Dim TreeViewString
	Dim TreeViewImg
	
	Sub TreeViewStart ( oid , url  )
		
		TreeViewImg = ""
		TreeViewString = "oid='" & oid & "'  url='" & url & "'"

		if len(url)> 0  then
			TreeViewString = TreeViewString &  " child='yes'"
		else
			TreeViewString = TreeViewString &  " child='no'"
		end if 
		
	End Sub

	Sub TreeViewItem (  item  )
	
		TreeViewString = TreeViewString & " item='" & item & "'"
	End Sub

	Sub TreeViewClickable ( bOpenClose )
	
		if ( bOpenClose ) then
			TreeViewString = TreeViewString & " clicktype='openclose'"
		else
			TreeViewString = TreeViewString & " clicktype='event'"
		end if
	End Sub

	Sub TreeViewImage( img )
		TreeViewImg = img 
	End Sub
	
	
	Sub TreeViewContent(   s  )

	%>
	<div  <%=TreeViewString%> >
	 <span> 
	<%
	
		if len( TreeViewImg ) > 0  then
		
	%>
	 <img src="<%=TreeViewImg%>" align="absMiddle"  />
	<%
		end if
	%>
	 <%=s%> </span>
	<%
	End Sub





	Sub TreeViewEnd()
	%>
		</div>
	<%
	End Sub



	Sub TreeViewChildStart (  )
	%>
		<div>
	<%
	End Sub

	Sub TreeViewChildEnd()
	%>
		</div>
	<%
	End Sub


Function NToZ( a )

	if ( len(a) > 0 ) then
		NToZ = a
	else
		NToZ = 0 
	end if
End Function 

Sub PrintTabBugHeight( dh )

	dh = dh + 30
'	response.write "<tr><td height=""" & dh & """ > <div style=""height:" & dh & """ /> </td></tr>"
	
End Sub

function getObjectPrivilege (userId, objId ) 
	dim str, query, rs
	str = "000000"
	
	query = "select PRIV_CD " &_
					" from VCO_USEROBJPRIV " &_
					" where USER_ID = '" & userId & "'" &_
					" and UPPER(OBJ_ID) = UPPER('" & objId & "')" 
					
	TableReadOpen rs, query
	if not rs.EOF then
		str = rs(0)
	end if
	rs.Close()
	getObjectPrivilege = str
end function

function isVisible ( act, userId, objId )
	dim bVisible, strPrv, idx, c
	bVisible = "false"
	strPrv = ""
	strPrv = trim(getObjectPrivilege ( userID, objId))
	Select Case UCase(act)
      Case "S"     idx = 0
      Case "I"     idx = 1
      Case "U"     idx = 2
      Case "D"     idx = 3
      Case "P"     idx = 4
      Case Else    idx = 5
  End Select
	 
	c = Mid (strPrv, idx+1 ,1)
	
	if c = "1" then
		bVisible = "true"
	end if
	isVisible = bVisible
end function

function getDisplayStr ( act, userId, objId )
	if isVisible (act, userId, objId) then
		getDisplayStr = ""
	else
		getDisplayStr = "display:none"
	end if
end function

function Authenticate2 ( userId, pwd, ip, name) 
		dim ret, msg
		Dim rs
		Dim cmd
		set cmd= Server.CreateObject("ADODB.Command") 
		ConnectDB
    cmd.ActiveConnection = conn
		cmd.CommandText="COMM.CHK_AUTHORIZATION_STP" 
    cmd.CommandType=adCmdStoredProc 
    cmd.Parameters.append cmd.CreateParameter("USR",adVarChar,adParamInput,20,userId) 
    cmd.Parameters.append cmd.CreateParameter("PWD",adVarChar,adParamInput,40,pwd) 
    cmd.Parameters.append cmd.CreateParameter("login_ip",adVarChar,adParamInput,20,ip) 		
		cmd.Parameters.append cmd.CreateParameter("login_com",adVarChar,adParamInput,100,name) 		
    cmd.Parameters.append cmd.CreateParameter("message",adVarChar,adParamOutput,100,msg)   		
    cmd.Parameters.append cmd.CreateParameter("succeed",adVarChar,adParamOutput,10,ret)             
    cmd.execute
		
		Authenticate2  =  cmd.Parameters(4).Value & "|" & cmd.Parameters(5).Value 
		CloseDB
end function

function GetUsingTimeInfo () 
	Dim rsLast, login_inf, hh, mm, dd
	Dim query
	login_inf = ""
	
	ConnectDB
	query = ""
	' Get last login information		
	if ((Session("LastLoginPK") <> "") and (Session("LastLoginPK") <> "0") ) then 
		query ="Select decode(USE_TIME,null,'',USE_TIME), to_char(CRT_DT,'DD Mon YYYY') || ' on ' || to_char(CRT_DT, 'HH24:MM') from COMM.TCO_BSLOGIN where PK = " & Session("LoginPK")
	else	
		if ((Session("LoginPK") <> "") and (Session("LoginPK") <> "0") ) then 
			query = "Select decode(USE_TIME,null,'',USE_TIME), to_char(CRT_DT,'DD Mon YYYY') || ' on ' || to_char(CRT_DT, 'HH24:MM') from COMM.TCO_BSLOGIN " &_ 
													 " where PK = (select max(PK) from COMM.TCO_BSLOGIN " &_
													 "						where PK < " & Session("LoginPK")	&_
													 "						and TCO_BSUSER_PK = " & session("USER_PK") &" )"
		end if
	end if
	
	if query <> "" then
		TableReadOpen rsLast, query
		if not rsLast.EOF then
			dd = rsLast(0) '"2.6879"
			if dd <> "" then
				hh = int(CDbl(dd)*24)
				mm = formatNumber( (CDbl(dd)*24 - hh)*60 , 2)
			end if
			login_inf  = rsLast(1) & ". And total using time is " & hh & " hour(s) and " & mm & " minute(s)"
		end if 
	end if
	CloseDB
	GetUsingTimeInfo = login_inf
end function

'Added by Ai Linh 09-Jun-2008
Function Spell3Digits(n)

dim Digit(9)
Dim N1 , N2, N3
Dim result, s
    Digit(1) = "một"
    Digit(2) = "hai"
    Digit(3) = "ba"
    Digit(4) = "bốn"
    Digit(5) = "năm"
    Digit(6) = "sáu"
    Digit(7) = "bảy"
    Digit(8) = "tám"
    Digit(9) = "chín"

    N1 = (n Mod 10) Mod 10
    n = n \ 10
    N2 = n Mod 10
    N3 = n \ 10

    If (N3 <> 0) Then result = Digit(N3) & " trăm " Else result = ""

    If N2 > 1 Then
    result = result & Digit(N2) & " mươi "
    ElseIf N2 = 1 Then
        result = result & "mười "
    Else: If (N1 > 0) And (N3 > 0) Then result = result & "lẻ "
    End If

    If N1 > 0 Then
    If (N1 = 1) And (N2 > 1) Then
        s = "mốt"
    ElseIf (N1 = 4) And (N2 > 1) Then
        s = "Tư"""
        ElseIf (N1 = 5) And (N2 > 0) Then
            s = "lăm"
        Else
         s = Digit(N1)
    End If
    result = result & s
    ElseIf result <> "" Then result = Left(result, Len(result) - 1)
    End If

    Spell3Digits = result
End Function

Function SpellNumber(n)
Dim GroupName(4)
Dim N1 , i 
Dim s, result
    GroupName(0) = " "
    GroupName(1) = " ngàn "
    GroupName(2) = " triệu "
    GroupName(3) = " tỉ "

    i = 0
    result = ""
    While (n > 0) And (i <= 3)
        N1 = n Mod 1000
        n = n \ 1000
        s = Spell3Digits(N1)
        If s <> "" Then result = s & GroupName(i) & result
            i = i + 1
    Wend
    If n > 0 Then
        result = result + " đồng"
    End If
    SpellNumber = result
End Function

Public Function spelldouble(so)
    Dim sole, songuyen , msoti
    Dim mkq , mkqle 
        mkq = ""
     If so > 1000000000 Then
    
       songuyen = Fix(so / 1000000000)
       msoti = Fix(so / 1000000000)
        mkq = SpellNumber(songuyen) & " tỉ "
        so = so - msoti * 1000000000
    End If


    sole = (so - Fix(so)) * 100
    songuyen = Fix(so)
    If sole > 0 Then
        If so > 0 Then
            mkqle = mkqle & " và " & SpellNumber(sole) & " Xu"
        Else
            mkqle = SpellNumber(sole) & " Xu"
        End If
    End If
    If so > 0 Then mkq = mkq & SpellNumber(songuyen) '& mkqle
    If Len(mkq) > 1 Then
        spelldouble = UCase(Left(mkq, 1)) & Mid(mkq, 2, 10000)
    Else
        spelldouble = mkq
    End If
    
End Function

Public Function Change3N(n) 
   dim Digit(15)
    dim Digit2(4)
    Dim result
    Dim N1, N2, N3 
    
    Digit(1) = "One"
    Digit(2) = "Two"
    Digit(3) = "Three"
    Digit(4) = "Four"
    Digit(5) = "Five"
    Digit(6) = "Six"
    Digit(7) = "Seven"
    Digit(8) = "Eight"
    Digit(9) = "Nine"
    Digit(10) = "Ten"
    Digit(11) = "Eleven"
    Digit(12) = "Tewlve"
    Digit(13) = "Thirteen"
    Digit(14) = "Fourteen"
    Digit(15) = "Fifteen"
    Digit2(2) = "Twenty"
    Digit2(3) = "Thirty"
    Digit2(4) = "Fourty"
    Digit2(5) = "Fifty"
    If n = 0 Then
        Change3N = " "
        Exit Function
    End If
    result = " "
    If n >= 100 Then
        N1 = n \ 100
        n = n Mod 100
        result = Digit(N1) & " Hundred "
    End If
    N2 = n Mod 10
    N3 = n \ 10
    Select Case n
        Case 0
            result = result
        Case 1,2,3,4,5,6,7,8,9,10,11,12,13,15,15
            result = result & Digit(n) & " "
        Case 16,17,18,19
            result = result & Digit(N2) & "teen "
        Case Else
            If N3 <= 5 Then
                result = result & Digit2(N3) & " "
            Else
                result = result & Digit(N3) & "ty "
            End If
            If N2 > 0 Then
                result = result & Digit(N2) & " "
            End If
    End Select
    Change3N = result
End Function

Public Function ChangeNumber(n)
    dim GroupName(4) 
    Dim N1 , i
    Dim s, result
    GroupName(0) = " "
    GroupName(1) = "Thousand "
    GroupName(2) = " Million "
    GroupName(3) = " Billion "

    i = 0
    result = ""
    While (n > 0) And (i <= 3)
        N1 = n Mod 1000
        n = n \ 1000
        If N1 > 0 Then
            s = Change3N(N1)
        End If
        result = s & GroupName(i) & result
        i = i + 1
    Wend
    If result = "" Then result = "Zero"
    ChangeNumber = result
End Function
Function English3Digits(n ) 
dim Digit(15)
Dim N1 , N2, N3
Dim result, s
    Digit(1) = "one"
    Digit(2) = "two"
    Digit(3) = "three"
    Digit(4) = "four"
    Digit(5) = "five"
    Digit(6) = "six"
    Digit(7) = "seven"
    Digit(8) = "eight"
    Digit(9) = "nine"
    Digit(10) = "ten"
    Digit(11) = "eleven"
    Digit(12) = "twelve"
    Digit(13) = "thirteen"
    Digit(15) = "fifteen"
    N1 = (n Mod 100)
  If N1 > 0 Then
    Select Case N1
      Case 10, 11, 12, 13, 15
        result = Digit(N1)
      Case Else
        N2 = N1 Mod 10
        N3 = N1 \ 10
        If N3 = 1 Then
          result = Digit(N2) & "teen"
        Else
          If N3 <> 0 Then
            Select Case N3
              Case 2
                result = "twenty"
              Case 3
                result = "thirty"
              Case 5
                result = "fifty"
              Case Else
                result = Digit(N3) & "ty"
            End Select
           End If
           If N2 <> 0 Then result = result & " " & Digit(N2)
        End If
    End Select
  End If
  n = n \ 100
  If (n <> 0) Then result = Digit(n) & " hundred " & result
  English3Digits = result
End Function
Function EnglishSpellNumber(n)
dim GroupName(4)
Dim N1 , i 
Dim s, result
    GroupName(0) = " "
    GroupName(1) = " thousand "
    GroupName(2) = " million "
    GroupName(3) = " billion "

    i = 0
    result = ""
    If n = 0 Then result = "zero"
    While (n > 0) And (i <= 3)
        N1 = n Mod 1000
        n = n \ 1000
        s = English3Digits(N1)
        If s <> "" Then result = s & GroupName(i) & result
            i = i + 1
    Wend
    EnglishSpellNumber = result
End Function

Public Function EnglishSpellDouble(so)
    Dim sole , songuyen 
    Dim mkq
    mkq = ""
    sole = (so - Fix(so)) * 100
    songuyen = Fix(so)
    If sole > 0 Then
        If so > 0 Then
            mkq = mkq & " point " & EnglishSpellNumber(sole)
        Else
            mkq = " zero point " & EnglishSpellNumber(sole)
        End If
    End If
    If so > 0 Then mkq = EnglishSpellNumber(songuyen) & mkq
    mkq = Trim(mkq)
    EnglishSpellDouble = UCase(Left(mkq, 1)) & Right(mkq, Len(mkq) - 1)
End Function


'End Added by Ai Linh 09-Jun-2008
%>
