<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Color Composition Registration</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_PK                       = 0,
        G1_color_code               = 1,
        G1_color_local_name         = 2;
        
    var G2_pk                       = 0,
        G2_tsh_color_pk             = 1,
        G2_tco_item_pk              = 2,
        G2_item_code                = 3,
        G2_item_name                = 4,
        G2_spec                     = 5,
        G2_unit_cd                  = 6,
        G2_unit                     = 7,
        G2_req_qty                  = 8,
        G2_percentage               = 9;       
        

 //---------------------------------------------------------
 function BodyInit()
 {
      shpb00050.Call("SELECT");
      BindingDataList();
      FormatGrid();
      txtColorName.SetEnable(false)
      txtCharger.SetEnable(false)
 }
  //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    {
        case '1':
            var col=event.col;
            var row=event.row;
            if(col==G2_unit||col==G2_unit_cd)
            {
                var path = System.RootURL + '/form/sh/ab/shab00080.aspx';
	            var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
	            if ( obj != null )
	               {
	                    grdDetail.SetGridText(row,G2_unit,obj[1]);
	                    grdDetail.SetGridText(row,G2_unit_cd,obj[6]);
	               }	
            }
        break;
        case '2':
                var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                    txtCharger.text = object[5];//charger name 
		            txtChargerPK.text = object[0];                         
                }
        break;
        
    }
}
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'grdColor':
            shpb00050.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=grdColor.GetGridData(grdColor.row,G1_PK);
            shpb00050_1.Call("SELECT");
        break;
        
    }
 }

//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
              
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstPlant.SetDataText(data);
       // lstPlant.value='';
        
        lstProductType.SetDataText('|1|GELATIN');
        lstProductType.value='1';
             
 }
 
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :
            if(txtMasterPK.text=="")
            {
                alert("Please Select Color");
            }
            else
            {
                 var path = System.RootURL + "/form/sh/ab/shab00010.aspx";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                        grdDetail.AddRow();
                        grdDetail.SetGridText( grdDetail.rows-1, G2_tsh_color_pk, txtMasterPK.text);
                        grdDetail.SetGridText( grdDetail.rows-1, G2_tco_item_pk, arrTemp[0]);
                        grdDetail.SetGridText( grdDetail.rows-1, G2_item_code,arrTemp[1] );
                        grdDetail.SetGridText( grdDetail.rows-1, G2_item_name, arrTemp[2]);
                        grdDetail.SetGridText( grdDetail.rows-1, G2_spec, arrTemp[3]);
                         grdDetail.SetGridText( grdDetail.rows-1,G2_unit_cd, arrTemp[6]);  
                        grdDetail.SetGridText( grdDetail.rows-1, G2_unit, arrTemp[7]);                    
                    }           
	             }
            }
             
        break;
      }  
 }
//---------------------------------------------------------
var flag="";
//---------------------------------------------------------

 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :
                if(txtMasterPK.text!="")
                {
                    shpb00050_1.Call();
                    flag="update";
                }    
            break;
      }  

 }

//---------------------------------------------------------

 function OnDelete()
 {
    if(grdDetail.row>0)
    {
        if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == "" ) 
	        {						
				    grdDetail.RemoveRow();					
		    }			
		    else 
		    {
			    if ( confirm( "Do you want to mark this row to delete?" ) ) 
			    {
				    grdDetail.DeleteRow();
			    }
		    }
    }
		
 }
 //---------------------------------------------------------
 function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'shpb00050_1':
            if(flag=="update")
            {
                shpb00050_2.Call();  
            }
            else
            {
                shpb00050_2.Call("SELECT");
            }   
        break;
        case'shpb00050_2':
            if(flag=="update")
            {
                shpb00050.Call("SELECT");
                flag="";
            }
        break;
    }
}
 //---------------------------------------------------------

 function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
      
      trl = grdDetail.GetGridControl();
      	
      trl.ColFormat(G2_req_qty )         = "###,###,###,###,###.#####";
      trl.ColFormat(G2_percentage )      = "###,###,###,###,###";
      
 }
 
//---------------------------------------------------------
function CheckInput()
{
    var  row, col 
        
    row = event.row ;
    col = event.col ; 
    if (col == G2_req_qty || col == G2_percentage )
    {      
        var dQuantiy
        dQuantiy =  grdDetail.GetGridData(row,col)
        if (Number(dQuantiy))
        {   
            if (dQuantiy <0)
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
    }
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00050"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00050" > 
                <input> 
                    <input bind="txtCodeName" /> 
                </input> 
                <output bind="grdColor" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00050_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shpb00050_1" parameter="0,1,2,3,4,5,6,7,8,9" procedure="PROD.sp_upd_shpb00050_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="txtColorCode" />
                    <inout bind="txtColorName" />
                    <inout bind="lstProductType" />
                    <inout bind="lstPlant" />
                    <inout bind="rdQCConfirm" />
                    <inout bind="dtConfirm" />
                    <inout bind="dtEnter" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtCharger" />
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00050_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="prod.sp_sel_shpb00050_2" parameter="0,1,2,3,4,5,6,7,8,9" procedure="prod.sp_upd_shpb00050_2"> 
                <input bind="grdDetail"> 
                    <input bind="txtMasterPK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 15%;white-space:nowrap" align="right">
                            <b>Color Code</b>
                        </td>
                        <td style="width: 30%" align="right">
                            <gw:textbox id="txtCodeName" styles='width:100%' onenterkey="OnSearch('grdColor')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdColor')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdColor' header='_PK|Color Code|Color Name' format='0|0|0' aligns='0|0|0'
                                defaults='||' editcol='0|0|0' widths='1000|1500|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right" >
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <b>Company</b>
                        </td>
                        <td style="width: 30%" align="right" colspan="2">
                            <gw:list id="lstPlant" styles='width:100%' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <b>Product Type</b>
                        </td>
                        <td style="width: 30%" align="right" colspan="2">
                            <gw:list id="lstProductType" styles='width:100%' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <b>Color Code</b>
                        </td>
                        <td style="width: 30%" align="right" colspan="3">
                            <gw:textbox id="txtColorCode" styles='width:30%' />
                            <gw:textbox id="txtColorName" styles='width:70%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <b>QC Confirm</b>
                        </td>
                        <td style="width: 30%" align="left">
                            <gw:radio id="rdQCConfirm" value="Y" styles="width:100%">                      
			                                <span value="Y" id="rdYes">YES</span>                       
			                                <span value="N" id="rdNo">NO</span>                   			                                
        			        </gw:radio>
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Confirm Date</b>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:datebox id="dtConfirm" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <b>Enter Date</b>
                        </td>
                        <td style="width: 30%" align="left">
                            <gw:datebox id="dtEnter" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                        </td>
                        <td style="width: 20%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Charger </b>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtCharger" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="4">
                            <table>
                                <tr>
                                    <td style="width: 96%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('grdDetail')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="4">
                            <gw:grid id='grdDetail' header='_PK|_TSH_COLOR_PK|_TCO_ITEM_PK|Item Code|Item Name|Spec|Unit CD|Unit|Reqd.Qty|Percentage(%)'
                                format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|3|3' defaults='|||||||||' editcol='0|0|0|0|0|0|0|1|1|1'
                                widths='1000|1000|1000|2000|2500|1000|1000|1000|1500|1500' sorting='T' styles='width:100%; height:100%'onafteredit="CheckInput()" oncelldblclick="OnPopUp('1')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
 <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
</html>
