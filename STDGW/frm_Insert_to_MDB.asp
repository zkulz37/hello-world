<%
	Dim data , ErrNo, ErrMsg
	set data = Request.Form("data")

	' Input Variables
	Dim filename
	Dim full_nm, card,emp_id
	dim accConn,str1,rs1,num_id
	dim rs

	num_id=0
	full_nm = request("f_nm")
	card = request("card_num")
	emp_id=request("empid")

	if emp_id="" then
		response.write 2
	else
		Set accConn = createObject("ADODB.Connection")  
		set conn = createObject("ADODB.Connection")
	
			
		accConn.Open "DSN=FPMS;UID=Admins;Password=fdmsamho"
		'strcon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Virdi\FPServer\Fpms.mdb;Jet OLEDB:Database Password=fdmsamho"
		'accConn.Open strcon
	
		str1 = "select count(b.id) as num from tuser b where b.id=" & Clng(right(emp_id,5)) & ""
	
		set rs1=server.CreateObject("ADODB.Recordset")
		rs1.Open str1, accConn
	
		if not rs1.EOF then
			num_id=rs1("num")
		
		else
			num_id=0
		
		end if
		
		rs1.Close
		
		
			if num_id=0 then
			   str = "insert into tuser (id,name,cardnum,remark,validtype,cancard,identify,padmin,reg_date,datelimit,badmin)"_
						& " values(" & Clng(right(emp_id,5)) & ",'" & full_nm & "','" & card & "','" & emp_id & "','3','0','0',7,Format(Date(),'yyyymmdd')+ Format(Time(),'HHMM'),'N' +Format(Date(),'yyyymmdd')+Format(Date(),'yyyymmdd'),0)"
					set rs=server.CreateObject("ADODB.Recordset")
					rs.Open str, accConn
					
			elseif card="" then 
			
					str="delete from tuser where id=" & Clng(right(emp_id,5)) 
					set rs=server.CreateObject("ADODB.Recordset")	
					rs.Open str, accConn
				
			else		
				str="update tuser set cardnum='" & card & "' where id=" & Clng(right(emp_id,5)) 
					set rs=server.CreateObject("ADODB.Recordset")	
					rs.Open str, accConn
			end if
			
		set accConn = nothing
		response.write 1
	end if
%>
