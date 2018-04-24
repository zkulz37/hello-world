<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>S/O Inquiry</title>
</head>
<%  ESysLib.SetUser("sale")%>

<script>

        
//-------------------------------------------------------------------------------------------
function BodyInit()
{  
    
}

//-------------------------------------------------------------------------------------------
function OnSearch()
{
    idGrid.GridRefresh()
    shmm00110.Call("SELECT")
}

//-------------------------------------------------------------------------------------------
function OnDataReceive(p_oData)
{
              
}
 //---------------------------------------------------------
 function OnPopUp(pos)
 {
      switch (pos)         
      {		        
        case 'BillTo' :
             var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
                txtPartnerID.text = object[1];
                txtPartnerName.text = object[2];
	         }
	    break;
	    case 'Dept': // PL
            var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[3]; 
               txtDeptCode.text  = object[1]; 
            }
        break;    
	  }  
 }  
 
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="shmm00110" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="inv.sp_sel_shmm00110" > 
                  <input > 
                     <input bind="dtOrderF" /> 
                     <input bind="dtOrderT" /> 
                     <input bind="txtDeptCode" /> 
                     <input bind="txtItemID" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table border="0" style="width: 100%; height: 100%">
        <tr style="height: 10%">
            <td width='100%'>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 50%">
                        <td width="10%" align="right">
                            Company
                        </td>
                        <td width="37%">
                            <gw:list id="lstCompany" styles='width:100%'>
                                <data>
								    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>||
							    </data>
							</gw:list>
                        </td>
                        <td align="right" nowrap>
                            Date
                        </td>
                        <td>
                            <gw:datebox id="dtOrderF" styles="width:100%" lang="1" onchange="OnSearch()" />
                            ~
                            <gw:datebox id="dtOrderT" styles="width:100%" lang="1" onchange="OnSearch()" />
                        </td>
                        <td width="5%" colspan="2" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 50%">
                        <td width="10%" align="right" style="white-space: nowrap">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dept')">Receipt Dept </b>
                        </td>
                        <td width="38%">
                            <gw:textbox id="txtDeptCode" styles="width:29%" onenterkey="OnSearch()" />
                            <gw:textbox id="txtDeptName" styles="width:70%" onenterkey="OnSearch()" />
                        </td>
                        <td align="right" style="white-space: nowrap">
                            <b>Malt Code/Name</b>
                        </td>
                        <td>
                            <gw:textbox id="txtItemID" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td align="right">
                        </td>
                </table>
            </td>
        </tr>
        <tr style="height: 90%">
            <td>
                <gw:grid id='idGrid' header='Date|Seq No.|Actual Qty|Unit Price|Actual Amount|Cancel Qty|Receipt Type|Test No.|Dept Name|Partner Code'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                    styles='width:100%; height:460' />
            </td>
        </tr>
    </table>
</body>
</html>
