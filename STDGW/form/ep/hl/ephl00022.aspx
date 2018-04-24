<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<%  ESysLib.SetUser("comm")%>
<head id="Head1" runat="server">
    <title>Search Export Declaration</title>
</head>

<script language="javascript" type="text/javascript">
    
   function BodyInit()
     {       
     
        System.Translate(document);  // Translate to language session
              
        var now = new Date(); 
        var lmonth, ldate;
                
        ldate=dtFromDate.value;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
        dtFromDate.value=ldate ; 
      
        grdDeclList.GetGridControl().FrozenCols = 6;
        BindingDataList();
       // SetGridFormat();
        <%=ESysLib.SetGridColumnComboFormat("grdDeclList", 4, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0020' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
     }
     //---------------------------------------------------------------------------------------------------------
     function BindingDataList()
     {   
        cboStatus.SetDataText('DATA|1|Saved|2|Confirmed|3|Cancelled')
         
     }
     
      //---------------------------------------------------------------------------------------
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {	        
	         
           case 0:// Customer 
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtCusName.SetDataText(aValue[2]); 
	                txtCusCode.SetDataText(aValue[1]);  
	                txtCusPK.SetDataText(aValue[0]);  
	            }	
	        break;  
	    }
    }   
    //----------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdDeclList.GetGridControl(); 
        ctr.ColFormat(10) = "#,###,###,###,###,###";
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
        ctr.ColFormat(12) = "#,###,###,###,###,###";
     
    }    
    //----------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        
    }
    //----------------------------------------------------------------------------
    function onSave()
    {
        if (ValidateData())
            dat_ephl00022.Call('');
    }
    //----------------------------------------------------------------------------
    function ValidateData()
    {
        for(var i=1; i<grdDeclList.rows; i++)
        {
            if((grdDeclList.GetGridData(i,2)=='-1')&& grdDeclList.GetGridData(i,8)=='')
            {   
                alert("You must input close date at row " + grdDeclList.GetGridData(i,1));
                return false;
            }
            if((grdDeclList.GetGridData(i,2)=='0')&& grdDeclList.GetGridData(i,8)!='')
            {   
                alert("You must check close at row " +grdDeclList.GetGridData(i,1));
                return false;
            }
        }
        return true;
    }   
    //-------------------------------------------------------------------
    function onSelect()
    {     
        code_data=new Array();
        if (grdDeclList.row >0)
        {
            for(j=0;j<grdDeclList.cols;j++)
            {
                code_data[code_data.length]=grdDeclList.GetGridData(grdDeclList.row,j);
            }            
	    }	  
	    window.returnValue = code_data; 
	    this.close();
    }
</script>
<body>
<!------------------------Get Contract List -------------------------------------->
<gw:data id="dat_ephl00022"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" function="IMEX.sp_sel_ephl00022"  > 
            <input bind="grdDeclList">                    
                <input bind="cboStatus" />  
                <input bind="dtFromDate" />
                <input bind="dtToDate" /> 
                <input bind="txtLiq_no" /> 
            </input> 
            <output bind="grdDeclList" /> 
        </dso> 
    </xml> 
</gw:data> 

<!-------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table cellpadding=0 cellspacing=0 style="width: 100%; height: 100%" border=0>
            
            <tr style="height: 1%"> 
                <td width="10%" nowrap>Liquid Date</td>
                <td width="8%"><gw:datebox id="dtFromDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="17%"><gw:datebox id="dtToDate" lang="1"  styles='width:100%;' onchange=""/></td>
                <td width="8%">Status</td>                
                <td width="15%"><gw:list id="cboStatus" styles="width:100%;" ></gw:list></td>                           
                <td width="15%" align='right' >Declaration No</td>
                <td><gw:textbox id="txtLiq_no"  text=""  styles='width:100%;'  /></td>
                <td width="5%"> <gw:imgbtn id="btnSearchExpPro" img="Search" alt="Search" text="Search" onclick="dat_ephl00022.Call('SELECT')" /> </td>
                <td width="5%"> <gw:imgbtn id="btnSelect" img="Select" alt="Search" text="Search" onclick="onSelect()" /> </td>
            </tr>        
            <tr style="height: 96%">
                <td colspan="16">
                     <gw:grid id='grdDeclList'
                    header='_PK|Liquid. NO|Liquid. SEQ|Liquid. DT|Remark|_TCO_COMPANY_PK|_custom_pk|Custom are|Custom Dept|_Status_code|Status|_Close_yn'
                    format='0|0|0|4|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1000|1000|1000|2000|1000|1500|1500|0|0|0|0'
                    sorting='T'
                    autosize='T' 
                    oncelldblclick ="onSelect()"
                    styles='width:100%; height:100%'
                    />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
