<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title> POP UP INSPECTION INCOMING </title>
</head>

<script type="text/javascript" language="javascript">

//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    //txtUser_PK.text = "<%=session("USER_PK")%>";
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
   //---------------------------- 
    
    //BindingDataList(); 
    
}

 //==================================================================================
function OnSelect()
{
    var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var index, rowNo
	
	index =0;
	rowNo = 0 ;
	
	if ( ctrl.SelectedRows == 0 )
    {
           return ;
    }
    else
	{
	    for(i=0; i < ctrl.SelectedRows; i++)
		{	  
		        rowNo = ctrl.SelectedRow(i)
		        for(j=0; j < idGrid.cols -1; j++)
	        	{
            		code_data[index] = idGrid.GetGridData(rowNo , j );
            		index ++;
            	}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}
//-------------------------------------------------------------------------------------
function OnCancel()
{
    var code_data=new Array()
    
    for( j=0 ; j < idGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//-------------------------------------------------------------------------------------
function OnSearch()
{
    data_kblc00101_search.Call("SELECT");
}

//====================================================================================
    
</script>

<body>
    
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00101_search" onreceive="">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00101"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtFileNoSearch"	/>	
					<input	bind="txtLCNoSearch"	/>	
				</input>	
				<output	bind="idGrid"	/>	
			</dso>	
		</xml>	
	</gw:data>
	
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 10%">
        <td>
            <table style="width: 100%; height: 100%">
                <tr>
                    <td align="right" style="width: 10%; ">
                                   Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                                <gw:datebox id="dtFromSearch" lang="1" />
                                ~
                                <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    <td align="right" style="width: 10%;">
                                    FILE NO
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtFileNoSearch" styles="width:100%;" />
                     </td>
                      <td align="right" style="width: 10%;">
                                    L/C NO
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtLCNoSearch" styles="width:100%;" />
                     </td>
                     <td style="width: 10%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                       <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                     </td>
                      <td style="width: 1%" align="right">
                        <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" />
                    </td>
                    <td style="width: 1%" align="right">
                        <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
                    </td>
                </tr>
            </table>
        </td>
                
        </tr>
        
        <tr style="height: 90%">
        <td colspan="8">
             <gw:grid id='idGrid'
            header='_PK|Slip NO|PO No|Invoice No|Item Name|Open Price|_STORED_FACT_CD|Stored Fact|_SHIPPER_CD|Shipper|_COMPANY_CD|Company|_ORIGIN_CD|Origin|_Price term|Mark|Inspec Num Of Rod|Net Wt(LB)|_INSPEC_NET_WT_KG|Doc Net Wt(LB)|_Doc Net Wt(KG)|Gap Net Wt|_Gap Net Wt(KG)'    
            format='1|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1'
            aligns='0|1|0|0|0|0|0|1|0|1|0|1|0|1|1|0|0|0|0|0|0|0|0'
            check='||||||||||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1200|1200|1300|3000|1500|1000|1300|1000|1300|1000|1300|1000|1300|1200|1200|1300|1500|1500|1500|1500|1500|1500'
            sorting='T'
            styles='width:100%; height:100%'oncellclick="OnSelect()" />
                
        </td>               
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<!--------------------------------------------------------->

</html>
