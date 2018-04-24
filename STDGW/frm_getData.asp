<%
	Dim data , ErrNo, ErrMsg,flag
	flag=0
	set data = Request.Form("data")

	' Input Variables
	Dim filename
	Dim dtTM
	dim user, pwd
	dim conn
	
	dtTM = request("date")
	user = request("nm")
	pwd = request("pd")
	set conn = createObject("ADODB.Connection")

			
	

	if ( conn.state = 0 ) then
		conn.Open "Provider=MSDAORA;Data Source=nobland" , user  , pwd 
		conn.BeginTrans
	end if
	
	'On Error Resume Next 
	Process 	

	if ( Err.Number = 0 ) then 
		conn.CommitTrans
		conn.close
	else
		conn.RollbackTrans 
		conn.close	
		session("Err_Num") = Err.Number
		session("Err_Msg") = Err.Source & "(" & Err.Description  & ")" 
	end if
%>

<%
function myConcate (str)
	Dim i
	Dim s
	s = str
	if (len(s) < 4) then
		for i = 1 to 4-len(s)
			s = "0" & s
		next
	end if
	myConcate = s
end function

sub insertData (eve, dt, tm, code,card, shift, machine, seq,etype)
	dim s, strsql 
	dim rs
	dim id
	s = myConcate(code) 'mid(code,2,len(code)-1)
	
	strsql = "INSERT INTO THR_TIME_TEMP ( PK, CARD_ID, MACHINE, TIME_DT,  TIME, SEQ, FLAG, SHIFT, CRT_DT, CRT_BY) "_ 
		& " Values (THR_TIME_TEMP_SEQ.NEXTVAL, '" & card &"','"_
		& myConcate(machine) & "', '" & dt &"',to_char(to_date('"_
		& Left(tm, 4) & "','HH24MI'),'HH24:MI'),'" & seq & "','N','"_
		& shift & "',sysdate,'" & session("LoginID") & "')"	

'response.Write(strsql & "<br>")
	set rs = server.CreateObject("ADODB.Recordset")
	
	rs.Open strsql, conn
	set rs = nothing
end sub

sub DeleteData
	dim rs

	set rs = Server.CreateObject("ADODB.Recordset")	
	rs.CursorType = adOpenKeyset
	rs.ActiveConnection = conn
	rs.Source = "Delete THR_TIME_TEMP where TIME_DT = '" & dtTM & "'"
	rs.Open

end sub

Function Process

	Dim cmd1
	Dim rs1 , str1 
	Dim accConn
	Dim eve, dt, tm, code, card,shift, machine, seq,etype
	
	Process = false
  eve = "" 
	dt = "" 
	tm = "" 
	code = ""
	shift = "" 
	machine = "" 
	seq = 0
	etype=0


	
	Set accConn = createObject("ADODB.Connection")  
	
	accConn.Open "DSN=FPMS;UID=Admins;Password=fdmsamho"
	'Response.Write "aaaa"
	'Response.End()

	'strcon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Virdi\FPServer\Fpms.mdb;Jet OLEDB:Database Password=fdmsamho"
	'accConn.Open strcon
			
	'Response.Write "aaaa"
	'Response.End()
str1 = "SELECT a.e_date,a.e_time,a.e_id, b.cardnum,a.e_idno, a.g_id, a.e_mode, a.e_type " & _
				" FROM tenter a,tuser b" & _
				" WHERE a.e_date = '" & dtTM &"' and a.e_result = '0' "&_
				" and a.e_id=b.id and g_id <>18  and b.cardnum<>'' and (a.e_type ='3' or a.e_type='0') "
			
'Open recordset on cmd1 and print it out.
   Set rs1 = createObject("ADODB.Recordset")
   rs1.Open str1, accConn
	 if not rs1.EOF then
	 	DeleteData
	 end if
	
   while not rs1.EOF
		'response.write rs1(0) & " "
		'response.write rs1(1) & " "
		'response.write rs1(2) & " "		
		'response.write "<BR>"			 

	  eve = " "
		dt = rs1(0) 
		tm = rs1(1) 
		code = rs1(2)
		card=rs1(3)
		shift = " " 
		machine = "0001"
		seq = seq + 1
		etype=rs1(7) ' phan biet user bam cai gi the =3, van tay=1
       if trim(dt) <> "" then
 			insertData eve, dt, tm, code, card, shift, machine, seq,etype			
		end if		
    rs1.MoveNext
   wend
	 
	rs1.Close
	set accConn = nothing
	Process = true
	if Process=true then
		flag=1
		Response.Write flag
	else
		flag=0
		Response.Write flag
	end if
End Function
%>
