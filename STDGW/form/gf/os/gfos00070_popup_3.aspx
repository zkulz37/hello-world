<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser("hr")%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
   // if (v_language!="ENG")
   //     System.Translate(document); 
	iduser_pk.text = "<%=session("USER_PK")%>";
	
  OnSearch();
  	
}
//-------------------------------------------
function OnSearch()
{
    
	dso_Bank.Call("SELECT");
}
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dso_Bank":
            
        break;
    }
}
//-------------------------------------------
function OnSelect()
{
    
    var code_data=new Array()
	var ctrl = idgrid.GetGridControl();
	
	if(ctrl.SelectedRows == 0)
    {
        alert("Please select an code.");
        return ;
    }
    else
	{
        
        code_data[1] = idgrid.GetGridData( ctrl.row , 1 );
        
		code_data[2] = idgrid.GetGridData( ctrl.row , 2 );
		code_data[3] = idgrid.GetGridData( ctrl.row , 3 );
		window.returnValue = code_data; 
	   	this.close(); 	
	 }
    
}

</script>
<body  >
<gw:data id="dso_Bank"   > 
        <xml> 
            <dso id="1" type="grid" function="acnt.sp_sel_gfos00070_popup_3"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="txtBank" /> 
                </input> 
                <output bind="idgrid" /> 
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->
  <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
              <fieldset style="padding: 2; width: 100%; height: 100%">
				<table border="0" width="100%" id="table2">
					<tr>
						<td align="right" width="15%">Giao dịch</td>
						<td width="85%"><gw:textbox id="txtBank" onenterkey="OnSearch()" text="" styles="width:100%" /></td>
					   <td><gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()"/></td>
						<td><gw:imgbtn id="btnSearch3" img="select" width="100%" img="in" text="Process" onclick="OnSelect()" /></td>
					</tr>
				</table>
			  </fieldset>
			</td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
               <gw:grid id="idgrid" header="Số thứ tự|Mã giao dịch |Tên giao dịch"
				format="0|0|0" 
				aligns="1|0|0" 
				defaults="|||" 
				editcol="0|0|0"
				widths="1000|1500|2000" 
				styles="width:100%; height:100%"
				sorting="T"  oncelldblclick="OnSelect()"/>
                   
            </td>
        </tr>
    </table>

<gw:textbox id="iduser_pk" styles="display:none; " />
</body>
</html>
