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
     l_prod_yn = "<%=request.QueryString("prod_yn")%>" ;
     txtPro_YN.text = l_prod_yn;
    //l_prod_yn = 'Y';
    BindingDataList();
   // shpb00111.Call("SELECT");
}

//-----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
        if (l_prod_yn =='Y')
        {
            data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||'-'||GRP_NM from  comm.tco_itemgrp where del_if=0 and prod_yn='Y' order by GRP_NM ")%>";
        }else
        {
            data = "<%=ESysLib.SetListDataSQL("SELECT pk, GRP_CD||'-'||GRP_NM from  comm.tco_itemgrp where del_if=0 and mat_yn='Y' order by GRP_NM ")%>";
        }
       lstGroup.SetDataText(data+"|ALL|Select All");    
       
       data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  order by a.ord ")%>";
       idGrid.SetComboFormat(G1_Size,data); 
        
      
       data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  order by a.ord ")%>";
      
       lstSize.SetDataText(data +'|ALL|Select All');
       lstSize.value='ALL';
       
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
       idGrid.SetComboFormat(G1_Size,data);  
        
       data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
       idGrid.SetComboFormat(G1_Cap_Print_Type,data);  
        
       data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
       idGrid.SetComboFormat(G1_Body_Print_Type ,data);  
        
   
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
           <dso id="1" type="grid" function="prod.sp_sel_shpb00111" > 
                  <input bind="idGrid" > 
                    <input bind="lstGroup" /> 
                    <input bind="lstSize" /> 
                    <input bind="txtItem" /> 
                    <input bind="rdPrint" /> 
                    <input bind="txtPro_YN" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%">
                Group
            </td>
            <td style="width: 15%" align="right" >
                <gw:list id="lstGroup" styles='width:100%' onchange="OnSearch()" />
            </td>
             <td style="width: 5%">
               Size
            </td>
            <td style="width: 15%" align="right" >
                <gw:list id="lstSize" styles='width:100%' onchange="OnSearch()" />
            </td>
            <td style="width: 5%" align="right">
                Item
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch()" />
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
        <tr>
            <td colspan=3 align="right">
                 <gw:radio id="rdPrint" value="Y" styles="width:98%; height:50%" onclick="OnSearch()" >                   
                            <span value="Y" id="Span1">Printed</span>                      
                            <span value="N" id="Span2">Unprinted</span>                   			                                
                </gw:radio>
            </td>
             <td colspan=5 align="right">
                 <gw:label id="lblRecord" text ="record" styles="color:blue" ></gw:label>
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="9">
                <gw:grid id='idGrid'
                header='_PK|Item Code|Item Name|SPEC|UOM|Size|_CAP_COLOR|_cap_corlor_cd|Cap Color|_BODY_COLOR|_Body_color_code|Body Color|_CAP_PRINT_COL|Cap Ink Color|Cap ArtWork|Cap Print Type|_BODY_PRINT_COL|Body Ink Color|Body ArtWork|Body Print Type|_TCO_BUSPARTNER_PK|Partner Id|Parter Name|Nation|_TAC_ABACCTCODE_PK'
                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                defaults='||||||||||||||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='0|1000|2500|2500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                sorting='T' autosize='T'
                styles='width:100%; height:100%'
                oncelldblclick ="OnSelect()"
                />
             </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
<gw:textbox id="txtPro_YN" styles="width:100%;display:none" />
</html>
