<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>General Machine Information</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var  G1_Mac_Code        = 0,
         G1_Mac_Name         = 1,
         G1_Size             = 2;
        
    var l_status = 0;

 //---------------------------------------------------------
 function BodyInit()
 {
      BindingDataList();
      txtProdHr.SetEnable(false);
      txtMaxCapa.SetEnable(false);
      txtProdCyl.SetEnable(false);
      txtConsump.SetEnable(false);
      txtTotalCapa.SetEnable(false);
      txtReqTimeCyl.SetEnable(false);
      lstMachine1.SetEnable(false);
      txtEmpName.SetEnable(false);
      
      txtCharger.text = user_pk;
      txtEmpName.text = user_name;
      
      OnSearch('Machine');
     
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
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'Machine':
            data_shpb00010.Call("SELECT");
        break;
        case 'Info':
            data_shpb00010_1.Call("SELECT");
        break;        
        case'Master': 
            txtMasterPK.text=grdColor.GetGridData(grdColor.row,G1_PK);
            shpb00060_1.Call("SELECT");
        break;
        
    }
 }
function OnMachineClick()
{
    lstMachine1.value = grdMachine.GetGridData(grdMachine.row,G1_Mac_Code )
    txtCharger.text = user_pk;
    OnSearch('Info') ;
}
//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
              
       data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
       lstMachine1.SetDataText(data);
        
       data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0020') FROM DUAL" )%>";    
       lstSize.SetDataText(data);
        
       data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
       lstCompany.SetDataText(data);
             
 }
//---------------------------------------------------------
 function OnSave()
 {
    if(CheckValid())
    {
        l_status = 1;
        data_shpb00010_1.Call();
    }
 }
//---------------------------------------------------------
function CheckValid()
{
    if(txtSpeed.text =='0' ||txtSpeed.text =='' )
    {
        alert('Please insert Machine Speed!')
        return false;
    }
     if(txtDipHr.text =='0' || txtDipHr.text =='' )
    {
        alert('Please insert Dipping Quantity/HR!')
        return false;
    }
     if(txtProdKg.text =='0' || txtProdKg.text =='' )
    {
        alert('Please insert Prod Quantity/KG!')
        return false;
    }
     if(dtApply.text =='' )
    {
        alert('Please select apply date!')
        return false;
    }
    return true;
}
//---------------------------------------------------------

 function OnDelete()
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
 
 
//---------------------------------------------------------
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shpb00010_1':
            if(txtSpeed.text =='0' || txtSpeed.text =='' )
            {
                 txtCharger.text = user_pk;
                 txtEmpName.text = user_name;
            }
           if(l_status==1)
           {
             data_shpb00010.Call("SELECT");
             l_status =0;
           }
        break;                 
    }
}
//----------------------------------------------------------
function OnDisplay()
{   
    if(txtSolQty.text=="")
    {
        alert("Please Input SolQty");
    }
    else if(!Number(txtSolQty.text))
    {
        alert("Please Input Numberic");
        txtSolQty.text="";
    }
    else if(Number(txtSolQty.text)<0)
    {
        alert("Value must greater than zero");
        txtSolQty.text="";
    }
    else
    {   
        for(var i=1;i<grdDetail.rows;i++)
        {
            var qty=grdDetail.GetGridData(i,2);
            var reqdqty=qty*txtSolQty.text;
            grdDetail.SetGridText(i,3,reqdqty);  
        }
        txtSolQty.text="";
    }
}
//------------------------------------------------------------------------------
function OnCalculate()
{
     txtProdCyl.text = 30*1219
    if (txtDipHr.text != '0')
    {
        txtProdHr.text = Number(txtDipHr.text) * 210   
        txtMaxCapa.text = Number(txtDipHr.text)*24 * 210
        if(txtProdKg.text != '0')
        {
            txtConsump.text = (Number(txtMaxCapa.text)/Number(txtProdKg.text) /24 - 0.01).toFixed(1)  
        }else
        {
            txtConsump.text = 0;
        }
    }else
    {
        txtProdHr.text = 0  
        txtMaxCapa.text = 0
        txtConsump.text =  0  
    }
    if(txtSpeed.text == '0')
    {
        txtReqTimeCyl.text = '0' 
    }else
    {
        txtReqTimeCyl.text = 1219/Number(txtSpeed.text)
    }
}
//------------------------------------------------------------------------------

function OnPopUp(pos)
{ 
   
    switch (pos)         
      {	
          case '1' :     
                   var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
	                 var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	                 if ( obj != null )
	                 {
	                    txtCharger.text   = obj[0];
	                    txtEmpName.text = obj[5];	                   
                     }	
          break;
          case '2' :     
                   var path = System.RootURL + '/form/sh/pb/shpb00011.aspx';
	               var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes',this);
	                 
          break;
     }
}

</script>

<body>  
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00010"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00010" > 
                <input bind="grdMachine" > 
                    <input bind="txtMachine" /> 
                 </input> 
                <output bind="grdMachine" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00010_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="control" user="prod" function="prod.sp_sel_shpb00010_1" parameter = '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19' procedure ="prod.sp_upd_shpb00010_1"> 
                <inout>     
                    <inout bind="lstMachine1" /> 
                    <inout bind="lstSize" />
                    <inout bind="txtSpeed" />
                    <inout bind="txtDipHr" />
                    <inout bind="txtProdKg" />
                    
                    <inout bind="txtProdHr" />
                    <inout bind="txtProdCyl" />
                    <inout bind="txtConsump" />
                    <inout bind="txtMaxCapa" />                    
                    <inout bind="rdStatus" />
                    
                    <inout bind="txtReqTimeCyl" />
                    <inout bind="txtBlendNo" />
                    <inout bind="txtCapPinNo" />                    
                    <inout bind="txtBodyPinNo" />
                    <inout bind="txtBinType" />
                    
                    <inout bind="txtTotalCapa" />
                    <inout bind="lstCompany" />                    
                    <inout bind="dtChange" />
                    <inout bind="dtApply" />
                    <inout bind="txtCharger" />
                    <inout bind="txtEmpName" />
                    
                 </inout> 
            </dso> 
        </xml> 
    </gw:data>    
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width:25%" id="left">
                <table style="width: 100%; height: 100%">                   
                    <tr style="height: 1%">
                        <td style="width: 30%" align="left">
                            <b>Machine</b>
                        </td>
                        <td style="width: 60%" align="right">
                            <gw:textbox id="txtMachine" styles='width:100%' onenterkey="OnSearch('Machine')" />
                        </td>
                        <td style="width: 10%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('Machine')" />
                        </td>
                     </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdMachine' header='_MC_code|Machine|Size' format='0|0|0' aligns='0|0|0'
                                defaults='||' editcol='0|0|0' widths='1000|1500|1000' sorting='T' styles='width:100%; height:100%'
                                onclick="OnMachineClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right">
                <table style="width: 100%; height: 100%" cellpadding=1; cellspacing=1>
                    <tr style="height: 5%">
                        <td colspan="5" style="width:98%" ></td>
                        <td style="width: 2%" align="right">
                            <gw:icon id="idBtnChange" img="2" text="Change" alt="Change Speed" styles='width:100%'
                                            onclick="OnSave()" />
                        </td>
                    </tr>
                    
                    <tr style="height: 5%">
                        <td style="width: 15%"  align="right">
                            <b>Company</b>
                        </td>
                        <td style="width: 60%" colspan=3 align="right" colspan="1">
                            <gw:list id="lstCompany" styles='width:100%' />
                        </td>
                         <td style="width: 15%" align="right">
                            <b>Change DT</b>
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtChange" lang="1" styles='width:50%' />
                        </td>                        
                        
                        
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Machine No</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:list id="lstMachine1" styles='width:100%' />
                        </td>
                         <td style="width: 20%" align="right">
                            <b>Size</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:list id="lstSize" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Apply DT</b>
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtApply" lang="1" styles='width:50%' nullaccept />
                        </td>                       
                    </tr>
                     <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Machine Speed</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                             <gw:textbox id="txtSpeed" styles='width:100%' csstype="mandatory" type="number"
                                            format="###,###,###.0R" onenterkey="OnCalculate()" />
                        </td>
                         <td style="width: 20%" align="right">
                            <b>Dip. Q'ty/HR</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:textbox id="txtDipHr" styles='width:100%' csstype="mandatory" type="number"
                                            format="###,###,###" onenterkey="OnCalculate()" />
                        </td>
                        <td style="width: 35%" colspan=3 rowspan=3 align="left">
                            <fieldset style=" height:100%">
                                <legend style="color: Black"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Pin No </b></legend>
                                <table style="width:100%; height:80%">
                                    <tr>
                                        <td style="width:40%" align="right">Cap</td>
                                        <td style="width:60%"><gw:textbox id="txtCapPinNo" styles='width:100%' csstype="mandatory" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >Body</td>
                                        <td><gw:textbox id="txtBodyPinNo" styles='width:100%' csstype="mandatory" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >Type</td>
                                        <td><gw:textbox id="txtBinType" styles='width:100%' csstype="mandatory" /></td>
                                    </tr>                                   
                                </table>
                            </fieldset>
                        </td>                     
                    </tr>
                   <tr tr style="height: 5%">
                     <td style="width: 15%" align="right">
                            <b>Prod. Q'ty/KG</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                             <gw:textbox id="txtProdKg" styles='width:100%' csstype="mandatory" type="number"
                                            format="###,###,###.##R" onenterkey="OnCalculate()" />
                        </td>
                         <td style="width: 20%" align="right">
                            <b>Prod. Q'ty/HR</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:textbox id="txtProdHr" styles='width:100%'  type="number"
                                            format="###,###,###" />
                        </td>
                   </tr>
                     <tr tr style="height: 5%">
                     <td style="width: 15%" align="right">
                            <b>Max.Capa</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                             <gw:textbox id="txtMaxCapa" styles='width:100%'  type="number"
                                            format="###,###,###.##R" />
                        </td>
                         <td style="width: 20%" align="right">
                            <b>Prod.Q'ty/CYL</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:textbox id="txtProdCyl" styles='width:100%'  type="number"
                                            format="###,###,###" />
                        </td>
                   </tr>
                     <tr tr style="height: 5%">
                     <td style="width: 15%" align="right">
                            <b>Sol.Consumption</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                             <gw:textbox id="txtConsump" styles='width:100%'  type="number"
                                            format="###,###,###.#0R" />
                        </td>
                         <td style="width: 20%; background-color:pink" align="right">
                            <b>Max Capa</b>
                        </td>
                        <td style="width: 20%; background-color:pink" align="right" colspan="1">
                            <gw:textbox id="txtTotalCapa" styles='width:100%'  type="number"
                                            format="###,###,###" />
                        </td>
                        <td colspan="2">
                            <fieldset>
                                <gw:radio id="rdStatus" value="Y" styles="width:100%">In Operation                     
			                                <span value="Y" id="rdYes">YES</span>                       
			                                <span value="N" id="rdNo">NO</span>                   			                                
        			            </gw:radio>
                            </fieldset>
                        </td>
                   </tr>
                   <tr tr style="height: 5%">
                     <td style="width: 15%" align="right">
                            <b>Reqd.Time/CYL</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                             <gw:textbox id="txtReqTimeCyl" styles='width:100%'  type="number"
                                            format="###,###,###.##R" />
                        </td>
                         <td style="width: 20%" align="right">
                            <b>Blending No</b>
                        </td>
                        <td style="width: 20%" align="right" colspan="1">
                            <gw:textbox id="txtBlendNo" styles='width:100%'  />
                        </td>
                        
                         <td  align="right">
                             <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Charger </b>
                        </td>
                        <td  align="right" colspan="1">
                            <gw:textbox id="txtCharger" styles='width:100%;display:none'  />
                            <gw:textbox id="txtEmpName" csstype="mandatory" styles='width:100%' />
                        </td>
                        
                   </tr>
                   <tr style="height: 10%">
                   </tr>
                   <tr  style="height: 50%">
                        <td colspan="6">
                            <table style="width:100%; height:100%; background-color:#99ccff" border=0 >
                                <tr style=" color:White; height:5%">
                                    <td style="width:15%"  align="center" >[Equation]</td>
                                    <td style="width:25%">1.Prod. Q'ty/HR</td>     
                                    <td style="width:60%">:(Dip. Q'ty/HR)*210 (7BAR = 210)</td>                               
                                </tr>
                                 <tr style=" color:White; height:5%">
                                     <td style="width:15%"></td>
                                     <td style="width:25%">2.Sol. Consumption</td>
                                      <td style="width:60%">:Max Capa./(Prod. Q'ty/KG)/24</td>                                    
                                </tr>
                                 <tr style=" color:White; height:5%">
                                    <td style="width:15%"></td>
                                    <td style="width:25%">3.Dip. Q'ty/HR</td>
                                     <td style="width:60%">:Machine Speed *60/210  (7BAR = 210)</td> 
                                </tr>
                                 <tr style=" color:White; height:5%">
                                     <td style="width:15%"></td>
                                     <td style="width:25%">4.Max Capa</td>
                                      <td style="width:60%">:Dip. Q'ty/HR * 24*210 (7BAR = 210)</td> 
                                </tr>
                                 <tr style=" color:White; height:5%">
                                     <td style="width:20%"></td>
                                     <td style="width:25%">5.Prod. Q'ty/CYL</td>
                                      <td style="width:55%">:30EA * 1219 (7BAR = 1219)</td> 
                                </tr>
                                 <tr style=" color:White; height:5%">
                                     <td style="width:15%"></td>
                                     <td style="width:25%">6.Reqd. Time/CYL</td>
                                      <td style="width:60%">:1219/Machine Speed (7BAR = 1219)</td> 
                                </tr>
                                <tr style=" color:White; height:5%">
                                     <td style="width:15%"></td>
                                     <td style="width:85%" colspan='2'>7.You Must Input Data of Machine Speed, Dip. Q'ty/HR and PROD. Q'ty/KG</td>
                                 </tr>
                                <tr style=" color:White; height:30%">
                                     <td style="width:20%"></td>
                                     <td style="width:25%"></td>
                                      <td style="width:55%"></td> 
                                </tr>
                            </table>
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
