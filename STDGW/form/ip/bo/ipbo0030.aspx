<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Select Color and Size</title>
</head>
<%  ESysLib.SetUser("stm")%>

<script>
function BodyInit()
{ 
    idCheck1.SetDataText("-1");    
    changeDate(1); 
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0016'" )  %> " ; 
    grdSO.SetComboFormat(3,data);    
}
//-----------------------------------
 function changeDate( m ) 
 {	
    var d1, d2;	var s, dt;	d1 = new Date;		
    if (d1.getMonth()-m < 1) 
    {		
        d2 = new Date(d1.getFullYear()-1, 12 + (d1.getMonth()-m), d1.getDate());			
    } 
    else 
    {	
        d2 = new Date(d1.getFullYear(), d1.getMonth()-m ,d1.getDate());	
    }
 	    //alert(d2);
 		s = d2.getMonth()+1;		
 		if (s < 10)
 		    {		
 		       dt = "" + d2.getFullYear() + "0" +s + d1.getDate();
 		 	} 
 		 	else 
 		 	{		
 		 	    dt = "" + d2.getFullYear()+s+d1.getDate();	
 		 	}	//alert(dt);
 		 		s ="" + m;	
	 		switch (s) 
	 		{
 				case "1" : 
 				    if (idCheck1.GetData() == -1) 
 				    {
	 								
				    dtFromDate.SetDataText(dt);				
				    idCheck3.SetData(0);				
				    idCheck6.SetData(0);							
				    }			
				break;		
				case "3" :			
					if (idCheck3.GetData() == -1) 
					{				
					dtFromDate.SetDataText(dt);				
					idCheck1.SetData(0);				
					idCheck6.SetData(0);							
					}					
				break;		
				case "6":			
					if (idCheck6.GetData() == -1) 
					{				
					dtFromDate.SetDataText(dt);				
					idCheck3.SetData(0);				
					idCheck1.SetData(0);							
					}					
				break;	
			}
	}
//-----------------------------------
    function onUpdate()
    {    
        ipbo0030.Call();
    }
//-----------------------------------
    function OnSearch()
    {    
        ipbo0030.Call("SELECT");
    }
//-----------------------------------
    function OnDataReceive(obj)
    {
        
    }
</script>
<body>
     <gw:data id="ipbo0030" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="stm.sp_sel_ipbo0030" parameter="0,6,7" procedure="stm.sp_upd_ipbo0030" > 
			    <input bind="grdSO" > 
			        <input bind="dtFromDate" />	
			        <input bind="dtToDate" />	
			        <input bind="txtSOId" />	
			        <input bind="txtPONum" />	
			    </input> 
			    <output bind="grdSO" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <table width="100%" border="0" style=" height:100%">
        <tr style=" height:5%">
            <td width="7%">
                <b>Order Date</b></td>
            <td width="10%">
                <gw:datebox id="dtFromDate" lang="<%=Session("Lang")%>" />
            </td>
            <td width="1%">
                <b>~</b></td>
            <td width="10%">
                <gw:datebox id="dtToDate" lang="<%=Session("Lang")%>" />
            </td>
            <td width="8%">
                <gw:checkbox id="idCheck1" mode="01" onclick="changeDate(1)"><b>1 Month</b></gw:checkbox>
            </td>
            <td width="8%">
                <gw:checkbox id="idCheck3" mode="01" onclick="changeDate(3)"><b>3 Months</b></gw:checkbox>
            </td>
            <td width="10%">
                <gw:checkbox id="idCheck6" mode="01" onclick="changeDate(6)"><b>6 Months</b></gw:checkbox>
            </td>
            <td width="6%">
                <b>Order ID</b></td>
            <td width="13%">
                <gw:textbox id="txtSOId" styles="width: 80%" onenterkey="OnSearch()" />
            </td>
            <td width="7%">
                <b>PO Number</b></td>
            <td width="13%">
                <gw:textbox id="txtPONum" styles="width: 80%" onenterkey="OnSearch()"/>
            </td>
            <td width="3%">
                <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="3%">
                <gw:imgbtn id="ibtnUpdate" img="save" alt="Update_Status" onclick="onUpdate()" />
            </td>
        </tr>
        <tr style=" height:95%">
            <td colspan="13" width="100%">
                <gw:grid id='grdSO'
                header='_PK|Order Id|Order Dt|Order Type|Po Num|Brand|Close YN|Description'
                format='0|0|4|0|0|0|3|0'
                aligns='0|0|0|0|0|0|0|0'
                defaults='|||||||'
                editcol='0|0|0|0|0|0|1|1'
                widths='0|1500|1200|1500|1500|1500|1000|2000'
                sorting='T'
                styles='width:100%; height:100%'
                />
            </td>
        </tr>
    </table>
</body>
</html>
