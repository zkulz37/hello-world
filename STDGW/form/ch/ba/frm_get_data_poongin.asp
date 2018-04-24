<%
	Dim data , ErrNo, ErrMsg,flag
	flag=0
	set data = Request.Form("data")

	' Input Variables
	Dim filename
	Dim dtTM
	dim user, pwd, fac
	dim conn
	
	dtTM = request("date")
	user = request("nm")
	pwd = request("pd")
	
	
	On Error Resume Next
	
	set conn = createObject("ADODB.Connection")

	if ( conn.state = 0 ) then
		conn.Open "Provider=MSDAORA;Data Source=poongin" , user  , pwd 
		conn.BeginTrans
	end if
	
	Process 		
	
	if ( Err.Number = 0 ) then 
		conn.CommitTrans
		conn.close
	else
		conn.RollbackTrans 
		conn.close	
		session("Err_Num") = Err.Number
		session("Err_Msg") = Err.Source & "(" & Err.Description  & ")" 
		response.write "ERROR:" & session("Err_Msg")
		response.end
	end if
	
%>

<%
function myConcate (str)
	Dim i
	Dim s
	s = str
	if (len(s) < 10) then
		for i = 1 to 10-len(s)
			s = "0" & s
		next
	end if
	myConcate = s
end function

sub insertData (dt, tm, code,card,etype,eve)
	dim s, strsql 
	dim rs
	dim id
	's = myConcate(code) 'mid(code,2,len(code)-1)

strsql = "INSERT INTO THR_TIME_TEMP ( PK, ID, EVENT, WORK_DT, TIME, LOCATION, CRT_DT,CRT_BY) "_ 
		& " select THR_TIME_TEMP_SEQ.NEXTVAL, '" & code & "','"_
		& eve & "', '" & dt &"',to_char(to_date('"_
		& Left(tm, 4) & "','HH24MI'),'HH24:MI'),1,sysdate,'" & session("LoginID") & "' from dual where '" & code & "' is not null "	


	set rs = server.CreateObject("ADODB.Recordset")
	
	rs.Open strsql, conn
	set rs = nothing
end sub

sub DeleteData
	dim rs

	set rs = Server.CreateObject("ADODB.Recordset")	
	rs.CursorType = adOpenKeyset
	rs.ActiveConnection = conn
	rs.Source = "Delete THR_TIME_TEMP where WORK_DT = '" & dtTM & "' and LOCATION=1"
	rs.Open

end sub

Function Process

	Dim cmd1
	Dim rs1 , str1 
	Dim accConn
	Dim eve, dt, tm, code, card,shift, machine, seq,etype
	
	dim emp,ttlEmp,dem
	dem=0
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
	
	accConn.Open "DSN=ACCESS;UID=Admins;Password=fdmsamho"
	'strcon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=d:test\FPMS.mdb;Jet OLEDB:Database Password=fdmsamho"
	
	'accConn.Open strcon

	
	str1 = "SELECT a.e_date,a.e_time,a.e_id, b.cardnum,a.e_idno, a.g_id, a.e_mode, a.e_type " & _
				" FROM tenter a,tuser b" & _
				" WHERE a.e_date = '" & dtTM &"' and a.e_result = '0' "&_
				" and a.e_id=b.id "
				
'Open recordset on cmd1 and print it out.
   Set rs1 = createObject("ADODB.Recordset")
   rs1.Open str1, accConn
	 if not rs1.EOF then
	 	DeleteData
	 end if

		
     while not rs1.EOF

	  
		dt = rs1(0) 
		'dt="20001007"
		tm = rs1(1) 
		'tm="111100"
		code = rs1(2)
		'code="123"
		card=rs1(3)
		'card="1"
		eve = rs1(6) ' phan biet user bam vao ra
		etype=rs1(7) ' phan biet user bam cai gi the =3, van tay=1
		'etype="1"
		if trim(dt) <> "" then
 			insertData dt, tm, code, card, etype,eve
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
