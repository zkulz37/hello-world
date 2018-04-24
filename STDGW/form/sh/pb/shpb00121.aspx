<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
var G1_pk             =0,
G1_Item_Code          =1,
G1_Item_name          =2,
G1_Spec               =3,
G1_UOM                =4,
G1_Size               =5,

G1_Cap_Col            =6,
G1_Cap_Col_ID         =7,
G1_Cap_Col_Nm         =8,

G1_Body_Col           =9,
G1_Body_Col_ID        =10,
G1_Body_Col_Nm        =11,

G1_Cap_Ink_Col        =12,
G1_Cap_Ink_Nm         =13,
G1_Cap_WordArt        =14,
G1_Cap_Print_Type     =15,

G1_Body_Ink_Col       =16,
G1_Body_Ink_Nm        =17,
G1_Body_WordArt       =18,
G1_Body_Print_Type    =19,

G1_Partner            =20,
G1_Partner_ID         =21,
G1_Partner_Nm         =22,
G1_Nation             =23,
G1_acc_code           =24;
     var  l_prod_yn         
//-----------------------------------------------------------

function BodyInit()
{
    var  partner    = "<%=request.QueryString("partner_type")%>" ;
    var  partner_id = "<%=request.QueryString("partner_id")%>" ;
    
}

//-----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
 }
function OnSearch()
{
    shpb00111.Call("SELECT");
}

//-----------------------------------------------------------

function OnSelect()
{
    var code_data=new Array();
	var ctrl = idGrid.GetGridControl();
	var index, rowNo;
	
	index =0;
	rowNo = 0 ;
	
	if ( ctrl.SelectedRows == 0 )
    {
           return ;
    }
    else
	{
	    for(var i=0; i < ctrl.SelectedRows; i++)
		{	  
		        rowNo = ctrl.SelectedRow(i);
		        for(var j=0; j < idGrid.cols -1; j++)
	        	{
            		code_data[index] = idGrid.GetGridData(rowNo , j );
            		index ++;
            	}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}

//-----------------------------------------------------------
function OnCancel()
{
    var code_data=new Array();
    
    for( var j=0 ; j < idGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
    window.returnValue = code_data; 
    this.close(); 	
}
//-----------------------------------------------------------
function OnReceiveData(obj)
{
    lblRecord.text = (idGrid.rows -1 ) +" record(s).";
}
</script>

<body>
    <!------------------------------------------------------------------------>
    <gw:data id="shpb00111" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shpb00121" > 
                  <input bind="idGrid" > 
                    <input bind="txtItem" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%">
                Item
            </td>
            <td style="width: 45%" align="right" >
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch()" />
            </td>
            <td style="width: 30%">
                <gw:label id="lblRecord" text ="record" styles="color:blue" ></gw:label>
            </td> 
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="6">
                <gw:grid id='idGrid'
                header='_pk|Item Code|Item Name|Spec|Uom|_tco_buspartner_pk|Partner ID|Partner Name|Nation|_tac_abacctcode_pk'
                format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||'
                editcol='0|0|0|0|0|0|0|0|1|0' widths='0|1200|3000|1500|600|0|1500|2000|1000|0'
                sorting='T' styles='width:100%; height:100%' oncelldblclick ="OnSelect()"
                />
             </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
<gw:textbox id="txtPro_YN" styles="width:100%;display:none" />
</html>
