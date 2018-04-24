<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Cotton Mixed Input Result</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;

var G1_PK                           = 0,
    G1_TLG_KB_PROD_RS_M_PK          = 1
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>"; 
   //---------------------------- 
    
    BindingDataList(); 
    data_kbre00040_master.StatusInsert();
    //data_kbre00040_search.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	   
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGGS0202' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";            
    lstShift.SetDataText( data);
    
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id||' * '||wh_name  FROM tlg_in_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>"; 	
	lstWH.SetDataText(data);
    
    data = "<%=ESysLib.SetListDataSQL(" SELECT   a.pk, a.line_id || ' - ' || a.line_name FROM tlg_pb_line a WHERE a.del_if = 0 ORDER BY a.line_id ")%>";     
    lstLine.SetDataText(data); 			 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'WAREHOUSE':
            var path = System.RootURL + '/form/fp/ab/fpab00240.aspx' ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                lstWH.value = obj[0];                 
            }
            break; 
			
            case 'Charger':
                var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                    txtChargerName.text = obj[2];
                    txtChargerPK.text   = obj[0];
                }
            break;            
            case 'SHIFT':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGGS0202";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGGS0202';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShift.value = object[1];      
	                }    	                
	             }                              
            break;
                                         
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'Master':           
            data_kbre00040_search.Call("SELECT");
        break;  
        case 'grdDetail':
            data_kbre00040_detail.Call("SELECT");
        break;
       case 'grdSub':
            data_kblc00140_sub.Call("SELECT");
        break;
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_kbre00040_search":
              OnSearch('grdDetail');     
        break;
        case "data_kbre00040_master": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_TLG_KB_PROD_RS_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G1_TLG_KB_PROD_RS_M_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }

        break;
    }
}
//====================================================================================

function Validate()
{   
   
    
   return true;
}

//====================================================================================

function OnSave(pos)
{ 
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_kbre00040_master.Call(); 
                flag='save';
            }           
        break;    
        case 'Detail':             
            data_kbre00040_detail.Call();
        break;  
        case 'Sub':        
            data_kblc00140_sub.Call();
        break;
    }
   
}
//====================================================================================

function OnAddNew()
{
    data_kbre00040_master.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kbre00040_master.StatusDelete();
       OnSave();
    }
 }

//====================================================================================
    
</script>

<body>
    <!-----------------------------LOGISTIC CODE------------------------------------->
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kbre00040_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso id="2"	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10"	function="<%=l_user%>lg_sel_kbre00040" > 	
				<input>			
					<inout	bind="txtSlipNo"	/>
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtWI_PK"	/>
					<inout	bind="dtIssusing"	/>
					<inout	bind="txtLotNo"	/>			
					<inout	bind="txtProdItem"	/>		
					<inout	bind="txtChargerPK"	/> 
					<inout	bind="txtChargerName"	/>
					<inout	bind="lstShift"	/>
					<inout	bind="lstWH"	/>
					<inout	bind="lstLine"	/>   		                 	
				</input>	
		
			</dso>	
		</xml>	
	</gw:data>
	
	 <!--============================================= Master =====================================-->
    <gw:data id="data_kbre00040_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso id="3"	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10"	function="<%=l_user%>lg_sel_kbre00040" procedure="<%=l_user%>lg_upd_kbre00040"> 	
				<input>			
					<inout	bind="txtSlipNo"	/>
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtWI_PK"	/>
					<inout	bind="dtIssusing"	/>
					<inout	bind="txtLotNo"	/>			
					<inout	bind="txtProdItem"	/>		
					<inout	bind="txtChargerPK"	/> 
					<inout	bind="txtChargerName"	/>
					<inout	bind="lstShift"	/>
					<inout	bind="lstWH"	/>
					<inout	bind="lstLine"	/>   		                 	
				</input>	
		
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_kbre00040_detail" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso id="4"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10"	function="<%=l_user%>lg_sel_kbre00040_1" procedure="<%=l_user%>lg_upd_kbre00040_1">	
				<input	bind="grdDetail">	
					<input	bind="txtMasterPK"	/>
					<input	bind="txtWI_PK"	/>							
				</input>	
				<output	bind="grdDetail"	/>
			</dso>	
		</xml>	
	</gw:data>
	 <!--============================================= Sub =====================================-->
    <gw:data id="data_kblc00140_sub" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="5"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbre00040_2" procedure="<%=l_user%>lg_sel_kbre00040_2">
				<input	bind="grdSub">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdSub"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
            <td>
                <table style="width: 100%; height: 100%">
            <tr style="height: 1%">
                <td style="width: 15%"></td>
                <td style="width: 30%"></td>
                <td style="width: 15%"></td>
                <td style="width: 10%"></td>
                <td style="width: 20%"></td>
                <td style="width: 1%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Master')" />
                 </td>          
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                </td>
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                </td>
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                </td>      
                <td style="width: 1%" align="right">
                   <gw:imgbtn id="btnPrint1" img="excel" alt="Print" text="Print" onclick="" />
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 15%;">
                                Date
                 </td>
                  <td style="width: 30%">
                       <gw:datebox id="dtIssusing" lang="1" />
                 </td>
                  <td align="right" style="width: 15%;"><a onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                         Charger</a>                              
                 </td>
                  <td  colspan ="7" style="width: 35%">
                       <gw:textbox id="txtChargerPK" styles="width:30%;" csstype="mandatory"/>
                       <gw:textbox id="txtChargerName" styles="width:70%;" csstype="mandatory"/>
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">Mixed Lot No
                 </td>
                  <td style="width: 30%">
                       <gw:textbox id="txtLotNo" styles="width:100%;"/>
                 </td>
                  <td align="right" style="width: 15%; "><a onclick="OnPopUp('SHIFT')" href="#tips" style="color: #0000ff">
                                Shift</a>
                 </td>
                  <td colspan="7" style="width: 35%">
                      <gw:list id="lstShift" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">WI
                 </td>
                  <td style="width: 30%">             
                       <gw:textbox id="txtSlipNo" styles="width:100%;" />                    
                 </td>
                  <td align="right" style="width: 15%;"><a onclick="OnPopUp('W/H')" href="#tips" style="color: #0000ff">
                                W/H</a>
                 </td>
                  <td colspan="7" style="width: 35%">
                      <gw:list id="lstWH" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">
                                Prod Item
                 </td>
                  <td style="width: 30%">
                       <gw:textbox id="txtProdItem" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 15%;">
                               Line
                 </td>
                  <td colspan="7" style="width: 35%">
                      <gw:list id="lstLine" styles="width:100%;" />
                 </td>
                 
            </tr>
            
           </table> 
            </td> 
        </tr>
        <tr style="height: 30%">
            <td style="width: 100%">          
                <gw:grid id='grdDetail'     
                    header='PK|TLG_KB_PROD_RS_M_PK|_TLG_IT_ITEM_PK|_ITEM_CODE|Item Name|WI Qty|Pale Qty|Qty KG|Pale Actual Qty|Qty Actual KG|Remarks'
                    format='1|1|1|0|0|1|1|1|1|1|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0'
                    check='||||||||||'
                    editcol='0|0|00|0|0|0|0|0|0|0|0'
                    widths='0|0|0|1000|2000|1300|1300|1300|1500|1500|1300'
                    sorting='T'        
                    styles='width:100%; height:100%'oncellclick="OnSearch('grdSub')" />              
            </td>          
        </tr>  
        <tr style="height: 50%">
             <td style="width: 100%">
                <gw:grid id='grdSub'
                    header='PK|TLG_KB_PROD_RS_D_PK|_TLG_IT_ITEM_PK|_ITEM_CODE|Item Name|Mat Lot No|Pale Qty|Qty KG|Pale Actual Qty|Qty Actual KG'
                    format='1|1|1|0|0|0|1|1|1|1'
                    aligns='0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||'
                    editcol='0|0|00|0|0|0|0|0|0|0'
                    widths='0|0|0|1000|2000|1300|1300|1300|1500|1500'
                    sorting='T'        
                    styles='width:100%; height:100%'/> 
                </td>                 
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtWI_PK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
