<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET SO/PO NO</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script> 
    
var G_SO_PK         = 0,
    G_SO_No         = 1,
    G_Ord_DT        = 2,
    G_PO_No         = 3,
    G_Style         = 4,
    G_BILL_TO_PK    = 5,
    G_Customer      = 6,
    G_Description   = 7;

//=======================================================================
function BodyInit()
{
    txtMasterPk.text="<%=Request.querystring("import_pk")%>";    
	System.Translate(document);
    //---------------------------    
    if(txtMasterPk.text!="")
    {
        data_kblc00183_master.Call("SELECT");
    }              
    else
    {
        data_kblc00183_master.StatusInsert();
    }
}
//=======================================================================

 function OnSearch()
 {
    data_kblc00183_master.Call('SELECT')
 }
   
//=======================================================================
function OnSelect()
{
    if(txtMasterPk.text!="")
    {
        var code_data = new Array();     
        var total =0;  
        for( j=1 ; j<grdDetail.rows ; j++ )
        {
            total = total + Number(grdDetail.GetGridData(j,3));

        } 
        code_data[0] = txtMasterPk.text;
        code_data[1] = total;
        
	    window.returnValue = code_data; 
	    this.close(); 	
	}
}
//=======================================================================
function OnCancel(oGrid)
{
    var code_data=new Array()
    
    for( j=0 ; j < oGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//=======================================================================
var flag="";
function OnDataReceive(obj)
{   
    switch(obj.id)
    {
        case'data_kblc00183_master':
       
            if(flag=="save")
            {
           
                for(i=1;i<grdDetail.rows;i++)
                {
                    if(grdDetail.GetGridData(i,1)=="")
                    {
                        grdDetail.SetGridText(i,1,txtMasterPk.text);
                    }
                }
                data_kblc00183_detail.Call();
            }
            else
            {
                data_kblc00183_detail.Call("SELECT");
            }
        break;
        case'data_kblc00183_detail':
            if(flag=="save")
            {
                if(txtMasterPk.text!="")
                {
                    alert("Save Finish ! Press Ok to close PopUp");
                    OnSelect();
                }
            }
        break;
    } 
}
//=======================================================================
function OnSave()
{
    flag="save";
    data_kblc00183_master.Call();
}
//======================================================================
function OnNew()
{
    grdDetail.AddRow();
}
//======================================================================
function OnDelete()
{
    if(grdDetail.GetGridData(grdDetail.row,0)=="")
    {
        grdDetail.RemoveRow();
    }
    else
    {
        grdDetail.DeleteRow();
    }
}
//=======================================================================
function OnCheckInput()
{
    var col = event.col;
    var row = event.row;
    
    if ( col == 3)
    {      
        var dQuantiy
        
        dQuantiy =  grdDetail.GetGridData(row,col)
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
         //---------------------------------------------
    } 
}
//=======================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_kblc00183_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0"	function="<%=l_user%>lg_sel_kblc00183"	procedure="<%=l_user%>lg_upd_kblc00183">	
				<inout>	
						<inout	bind="txtMasterPk"	/>
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kblc00183_detail" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3" function="<%=l_user%>lg_sel_kblc00183_1" procedure="<%=l_user%>lg_upd_kblc00183_1"> 
                <input bind="grdDetail" >
                    <input bind="txtMasterPk" />
                </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 10%; white-space: nowrap">
            </td>
            <td style="width: 50%">
            </td>
            <td align='right' style="width: 10%; white-space: nowrap">
            </td>
            <td style="width: 20%; white-space: nowrap">
            </td>
            <td style="width: 7%">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="new" alt="New" id="btnNew" onclick="OnNew()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td align="right" style="width: 1%">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='_PK|_MasterPK|Sale No|Amount' format='0|0|0|1' aligns='0|0|0|0'
                    check='|||' editcol='1|1|1|1' widths='1400|1400|1400|2000' sorting='T' styles='width:100%; height:100%' onafteredit="OnCheckInput()"/>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
<gw:textbox id="txtMasterPk" styles='width:100%;display:none' />
</html>
