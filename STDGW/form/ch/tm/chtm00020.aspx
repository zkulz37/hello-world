<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
  <style type="text/css">
  
  html, body {
                 
                margin: 0;
                padding: 0;
                
            }
 
 #poup{
	position: relative;
	background-image: url("assets/hinh/nen4.jpg");
	margin-left: 5px;
	margin-top: 0px;
    background-repeat: no-repeat;
	height: 260px; 
	
}
 


 #poup #title{
 position: absolute;
	font-size: 200%;
	 text-align: center;
	  color: red;
	 
	top: 5px;
	margin-left: 150px;
}

#poup #imn1 {
	position: absolute;
	left: 215 px;
	top: 140 px;
}

#poup   #imn2 {
	position: absolute;
	left: 215px;
	top: 60px;
	
}
#poup   #imn3 {
	position: absolute;
	left: 257px;
	top: 30px;
	
}

#poup  #imn4 {
	position: absolute;
	left: 305px;
	top: 30px;	
}

#poup   #imn5 {
	 position: absolute;
	left: 348px;
	top: 52px;
	
}


#poup  #imn10 {
	position: absolute;
	left: 15px;
	top: 54px;
	
}

#poup #imn9 {
	 position: absolute; 
	left: 57px;
	top: 30px;
	
	
}

#poup  #imn8 {
	  position: absolute; 
	left: 105px;
	top: 30px;
	
}

#poup   #imn7 {
	  position: absolute;
	
	left:145px;
	top: 64px;
}

#poup   #imn6 {
	 position: absolute;
	left: 145px;
	top: 140px;
	
}

#poup #bun10{
	 
	width:100px;
	margin-left: 40%;
}
 
div p {
	color: #ff0000;
}
</style>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var check_init=0;
var view_process=false;
var MenuTitle="10070002 Finger Register";
var stop_interval=false;




	
function tabUnActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                              //alert('hide' + menu_id);
							  stop_interval=true;
               }
function tabActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                            //  alert('Show' + menu_id);
							  stop_interval=false;
               }
	

function LoadHand(val){
var  image1 =  '' ;
//alert(val);
//var oMyObject = window.dialogArguments;
//var image1 = oMyObject.image1;
if (val!="")
	val=val+",";
for(var i =1 ;i<11;i++){
	{var obj = document.getElementById("imn"+i);
	
	if(val=="")
		{obj.src="assets/finger_picture_05.gif";
		 //obj.src="assets/finger_picture_03.gif";
		}
		else
		{ var temp=val.indexOf(i+",");
				
				if (temp>=0)
				{obj.src="assets/finger_picture_03.gif";
				
				}
				else
				obj.src="assets/finger_picture_05.gif";
				//alert(obj.src);
				
				//obj.src="assets/finger_picture_03.gif";
		}
	}	
		
		
}

//changeimg(image1);
}
function changeimg(index){
document.getElementById("imn"+index).src= "assets/finger_picture_03.gif";
}


	
function BodyInit()
{

//alert(Math.floor(16/10));
 LoadHand("");
    txtOrg_tmp_pk.text="<%=Session("COMPANY_PK")%>";
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    grdEmployee.GetGridControl().ScrollTrack=true;
    
    
    
	Hidden("none");
	SetEnable(false);
    ChangeColorItem(lstOrg.GetControl());
	btnDispaly.SetEnable(false);
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	
}


//
function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }


function SetEnable(ob)
{
txtEmpPK.SetEnable(ob);
txtEmpID.SetEnable(ob);
txtIDNum.SetEnable(ob);            
txtPhoto_PK.SetEnable(ob);
txtFullName.SetEnable(ob);                    
//txtCardID.SetEnable(ob);
txtCurAdd.SetEnable(ob);
txtPerAdd.SetEnable(ob);
txtOrganization.SetEnable(ob);
txtGroup.SetEnable(ob);
txtEmpType.SetEnable(ob);        
txtTel.SetEnable(ob);          
txtSex.SetEnable(ob);      
txtStatus.SetEnable(ob);      
txtJoinDate.SetEnable(ob);         
txtLeftDate.SetEnable(ob);           
txtNation.SetEnable(ob);           
txtBirthPlace.SetEnable(ob);         
txtBirthDate.SetEnable(ob);             
txtPersonID.SetEnable(ob);            
txtPersonIDPlace.SetEnable(ob);           
txtIssuedDate.SetEnable(ob);                
txtPos.SetEnable(ob);             
txtJob.SetEnable(ob);      
txtEdu.SetEnable(ob);      
txtEthnic.SetEnable(ob);      
txtReligion.SetEnable(ob);         
txtMarital.SetEnable(ob);           
txtFCount.SetEnable(ob);          
txtFInfo.SetEnable(ob);		
		

}
//-----------------------------------------------

 
function OnDataReceive(obj)
{
    if (obj.id=="datOrgData")
    {
            if(txtHr_level.text=="6")
                txtOrgData.text=txtOrgData.text+"|ALL|Select All";
            lstOrg.SetDataText(txtOrgData.text)    ;
            
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj. options.selectedIndex=0;
    
        
        //datGroupData.Call();
    }
	else if(obj.id=="datUser_info")
	{
		datGetBranch.Call();
	}
	else if(obj.id=="datGetBranch")
	{
		datAccessGroup.Call();
	}
   else if (obj.id=="datEmployee_Detail_Search")
   {
        imgFile.SetDataText(txtPhoto_PK.text);
		try{
		var objUCBioBSP = new ActiveXObject("UCBioBSPCOM.UCBioBSP.1");
		var objFPData = objUCBioBSP.FPData;
		var Fpdata=txtFPText1.text+txtFPText2.text+txtFPText3.text+txtFPText4.text;
		if(Fpdata!=""   )
		{	objFPData.Export(Fpdata, 400);
			txtFCount.text=objFPData.TotalFingerCount;
			txtFInfo.text="";
			for (var i = 0; i < objFPData.TotalFingerCount; i++)
                        {
                            var nFingerID = objFPData.FingerID(i);
							if(txtFInfo.text=="")
							{txtFInfo.text+=nFingerID;
							}
							else
							txtFInfo.text+=","+nFingerID;
						}
						
		//objExtraction.TextFIR=txtFPText.text;
		}
		}
		catch(e)
	{
		//alert(e.message);
		//return(false);
	}
		LoadHand(txtFInfo.text);
		datGroupMapping.Call("SELECT");
		
    //  auto_resize_column()
   }
   else if(obj.id=='datEmployee_Main_Search')
   {
		fillColor();
		auto_resize_column(grdEmployee,0,grdEmployee.cols-1,0);
   }
   else
   if (obj.id=="datGroupMapping")
   {
   auto_resize_column(grdMapping,0,grdMapping.cols-1,0);
   } else if(obj.id=='dataUpdateFingerPrint')
   {
		for(var i=1; i<= grdEmployee.rows-1;i++)
		{ if(grdEmployee.GetGridData(i,0)==txtEmpPK.text)
				{ grdEmployee.SetGridText(i,9,txt_user_status.text);
				grdEmployee.SetGridText(i,1,'-1');
				grdEmployee.SetGridText(i,6,txtFCount.text);
				}
		if(grdEmployee.GetGridData(i,9)=='2')
			{grdEmployee.SetCellBgColor(i, 0, i, grdEmployee.cols-1, 0x0000ff );
			}
		if(grdEmployee.GetGridData(i,9)=='1')
			{grdEmployee.SetCellBgColor(i, 0, i, grdEmployee.cols-1, 0x00ffff );
			}	
		}
		
   }
   else if(obj.id=="datStatus")
   {
	if(view_process==false)
	   {	grdEmployee.style.display="none";
			grdEmployee2.style.display="";
			btnDispaly.SetEnable(true);
			btnDispaly.text="Stop view processing";
			view_process=true;
			clear_Interval();
			set_Interval(time_deplay);
			datStatus.Call("SELECT");
			
	   }
	   else
	   { var temp=0;
	    for(var i=1 ;i<= grdEmployee2.rows-1;i++ )
			{ if(grdEmployee2.GetGridData(i,3)!="0")
					{temp=1;
					break;
					}
			}
			if(temp==0)
			{
			alert("Procesing is complete");
			grdEmployee.style.display="";
			grdEmployee2.style.display="none";
			btnDispaly.SetEnable(false);
			btnDispaly.text="View processing";
			view_process=false;
			clear_Interval();
			txt_key.text="";
			datEmployee_Main_Search.Call("SELECT");
			}
	   }
   auto_resize_column(grdEmployee2,0,grdEmployee2.cols-1,0);
   }
   
}

function OnShowProcess()
{
			grdEmployee.style.display="";
			grdEmployee2.style.display="none";
			btnDispaly.SetEnable(false);
			btnDispaly.text="View processing";
			view_process=false;
			clear_Interval();
			txt_key.text="";
			datEmployee_Main_Search.Call("SELECT");
			
}
var time_deplay=10000;
var startTime,interval_time,time_count;
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 time_count= new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",100);
}
function clock(start,x) 
{

if(stop_interval)
	{
	//clear_Interval();
	return;
	}

 var d = new Date();
     
	if(Math.round((d.valueOf()-time_count)/100)+""!=idInterval.text)
	{
		idInterval.text=Math.round((d.valueOf()-time_count)/100)+"";
	} 
	 
	if(Math.round((d.valueOf()-startTime))>x)
	{
		{
		startTime=new Date().valueOf();
		datStatus.Call('SELECT');
		
		}
	
	
	}
	
}
function clear_Interval()
{   idInterval.text="";
	clearInterval(interval_time);
	
}

function fillColor()
{ for(var i=1; i<= grdEmployee.rows-1;i++)
    { if(grdEmployee.GetGridData(i,10)=='2')
		{grdEmployee.SetCellBgColor(i, 0, i, grdEmployee.cols-1, 0x0000ff );
		}
	  if(grdEmployee.GetGridData(i,10)=='1')
		{grdEmployee.SetCellBgColor(i, 0, i, grdEmployee.cols-1, 0x00ffff );
		}	
	}
}
//------------------------------------------------
function OnChangeOrg()
{
    

}

//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+ window.event.screenY +';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
    }
    
}

function OnShowTerminal(option)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/tm/chtm00020_2.aspx?";
   // var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:80;dialogHeight:50;dialogLeft:'+window.event.screenX+30+';dialogTop:'+ window.event.screenY +';edge:sunken;scroll:yes;unadorned:yes;help:no');
		var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:40;dialogHeight:30;dialogLeft:100;dialogTop:300;edge:sunken;scroll:yes;unadorned:yes;help:no');
	grdEmployee2.ClearData();
	view_process=false;
	if (obj!=null)
    { grdEmployee2.ClearData();
	  txt_key.text=  new Date().valueOf()  + "" +iduser_pk.text ;
		for(var i=1;i<=grdEmployee.rows-1;i++)
			{  
				if(grdEmployee.GetGridData(i,1)=="-1")
				{grdEmployee2.AddRow();
					var idx=grdEmployee2.rows-1;
					grdEmployee2.SetGridText(idx,0,grdEmployee.GetGridData(i,0));
					grdEmployee2.SetGridText(idx,4,obj[1]);
					grdEmployee2.SetGridText(idx,5,obj[0]);
					grdEmployee2.SetGridText(idx,6,txt_key.text);
					grdEmployee2.SetGridText(idx,7,option);
				}
			}
			
		if(grdEmployee2.rows>1)
			{datStatus.Call();}
			else
			alert("Please chose employee send to terminal");
        //lstOrg.value=obj;
    }
    
}
//-----------------------------------------------
function OnToggle(n)
{  if(n==0)
    {if(imgArrow.status == "expand")
    {
        idLeftDiv.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        idLeftDiv.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
    }
	else
	{
		if(img_temp.status == "expand")
        {
            img_temp.status = "collapse";
			Hidden("none");
			
            img_temp.src = "../../../system/images/iconmaximize.gif";
			img_temp.alt="Show Column";
        }
        else
        {
			Hidden("");
            img_temp.status = "expand";
            img_temp.src = "../../../system/images/close_popup.gif";
			img_temp.alt="Hide Column";
        }
	}
}
 function Hidden(ob)
 { 
	r1.style.display=ob;
	r2.style.display=ob;
	r3.style.display=ob;
	r4.style.display=ob;
	r5.style.display=ob;
	r6.style.display=ob;
	
			
	
 }
//------------------------------------------------
function OnSearch()
{
	
		datEmployee_Main_Search.Call("SELECT");
	
}
//-------------------------------------------------
function OnClickRow()
{
    var col=grdEmployee.GetGridControl().col
    if(col!=1)
    {
        txtEmpPK.text=grdEmployee.GetGridData(grdEmployee.row,0);
        imgFile.MasterPK = txtEmpPK.text;
        datEmployee_Detail_Search.Call("SELECT");
    }    
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//--------------------------------------------------
function OnReport()
{
		
}

function OnSelectAll(obj_checkbox,obj_grd)
{	
    var ctrl=obj_grd.GetGridControl();
    var temp ="";
	if(obj_checkbox.value=="T")
	temp="-1";
	else
	temp="0";
	if(ctrl.SelectedRows>0)
		for(var i=0;i<ctrl.SelectedRows;i++)
         {               obj_grd.SetGridText(ctrl.SelectedRow(i),1,temp);
         }
		 else
		 {
		 for(var i=1;i<=obj_grd.rows-1;i++)
         {               obj_grd.SetGridText(i,1,temp);
         }
		 }
}

function Enroll() {
    var user_id_login = "<%=Session("USER_ID")%>";
    //alert(user_id);
    var user_id = "";

    var err, payload;
    var result = false;

    // Check ID is not NULL
    /*if ( user_id == "" )
	{
		alert("Please enter user id!");
		return(false);
	}*/

    try // Exception handling
    {
        DEVICE_AUTO_DETECT = 255;


        var objUCBioBSP = new ActiveXObject("UCBioBSPCOM.UCBioBSP.1");
        var objDevice = objUCBioBSP.Device;
        var objExtraction = objUCBioBSP.Extraction;
        var objFPData = objUCBioBSP.FPData;



        // Open device.
        // You must open device before enroll.
        objDevice.Open(DEVICE_AUTO_DETECT);

        err = objUCBioBSP.ErrorCode;

        // Get error code	
        if (err != 0)		// Device open failed
        {
            alert("Device open failed!");
        }
        else {
            // Enroll user's fingerprint.
            //objDevice.Open(0xff);
            objExtraction.Enroll(payload);
            err = objUCBioBSP.ErrorCode;	// Get error code

            if (err != 0)		// Enroll failed
            {
                alert("Registration failed! [Error : " + err + " (" + objUCBioSBP.ErrorDescription + ")]");
            }
            else	// Enroll success
            {
                // Get text encoded FIR data from NBioBSP module.
                //document.MainForm.FIRTextData.value = objExtraction.TextFIR;
                //var string_finger=
                //alert("Registration success!");
                //result = true;
                ////////////////////////////////////////////////////////////////////////////////
                // kks test
                //fpData.Import(1, nFingerID, 2, 400, 400,biFPData1 , biFPData2);

                err = objFPData.Export(objExtraction.TextFIR, 400);
                //alert(objExtraction.TextFIR);
                my_split(objExtraction.TextFIR);





                txtFCount.text = objFPData.TotalFingerCount;
                txtFInfo.text = "";
                for (var i = 0; i < objFPData.TotalFingerCount; i++) {
                    var nFingerID = objFPData.FingerID(i);
                    if (txtFInfo.text == "") {
                        txtFInfo.text += nFingerID;
                    }
                    else
                        txtFInfo.text += "," + nFingerID;
                    //	var   nFPDataSize1 = objFPData.FPSampleDataLength(nFingerID, 400);

                }



                //alert("### FpCount = " + value);
                //	value = objFPData.FingerID(0);
                //alert("### FingerID = " + value);
                //OnSetFinger(value,objExtraction.TextFIR);
                ////////////////////////////////////////////////////////////////////////////

            }

            // Close device. [AUTO_DETECT]
            objDevice.Close(DEVICE_AUTO_DETECT);
        }

        objExtraction = 0;
        objDevice = 0;
        objUCBioBSP = 0;
        LoadHand(txtFInfo.text);

    }
    catch (e) {
        alert(e.message);
        LoadHand('');
        return (false);
    }

    /*if ( result )
	{
		// Submit main form
		document.MainForm.submit();
	}
	return result;*/
}

function my_split(text)
{ var arr= new Array();
	var str="";
	var idx=0;
	//alert(text.length+"   ===="+Math.floor(text.length/4000));
	if (Math.floor(text.length/4000)<1)
		{
		txtFPText1.text=text.substr(0,text.length);
		//alert("1");
		}
	else{
		if (Math.floor(text.length/4000)<2)
			{
			txtFPText1.text=text.substr(0,4000);
			txtFPText2.text=text.substr(4000,text.length-4000);
			//alert("2");
			}
			else{
				if (Math.floor(text.length/4000)<3)
					{
					txtFPText1.text=text.substr(0,4000);
					txtFPText2.text=text.substr(4000,4000);
					txtFPText3.text=text.substr(8000,text.length-8000);
					//alert("3");
					}
					else{
						if (Math.floor(text.length/4000)<4)
							{
							txtFPText1.text=text.substr(0,4000);
							txtFPText2.text=text.substr(4000,4000);
							txtFPText3.text=text.substr(8000,4000);
							txtFPText4.text=text.substr(12000,text.length-12000);
							//alert("4");
							}
						}
				}
		}
	
	
}
function DeleteFinger()
{   txtFCount.text=0;
	txtFInfo.text='';
	txtFPText4.text="";
	txtFPText3.text="";
	txtFPText2.text="";
	txtFPText1.text="";
	LoadHand('');
}
function onSave()
{ if(confirm("Do yopu want to save"))
	{ var str="";
		for(var i=1;i<=grdMapping.rows-1;i++ )
		{ var temp= grdMapping.GetGridData(i,1)+"";
			if(temp=='-1')
				{ 
					str=str+grdMapping.GetGridData(i,0)+",";
				}
		}
		txtMapping.text=str;
		/*alert(txtFPText1.text);
		alert(txtFPText2.text);
		alert(txtFPText3.text);
		alert(txtFPText4.text);*/
		dataUpdateFingerPrint.StatusUpdate();
		dataUpdateFingerPrint.Call();
	}
}
function OnDataError(obj)
{
alert("Have error");
}
</script>
<body >

<gw:data id="datEmployee_Main_Search"  onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10070002_EMP_SEARCH" > 
                <input bind="grdEmployee" >
                    <input bind="lstOrg" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="chkTemp" />
                    <input bind="txtTemp" />
					<input bind="lstNation" />
					<input bind="lstStatus" />
					<input bind="lstFinger" />
					<input bind="lstBranch" />
					<input bind="lstAccessGoup" />
					
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>


<!------------------------------->
<gw:data id="dataUpdateFingerPrint" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function = "HR_SEL_10070002_FingerPrint" procedure="HR_UP_10070002_FingerPrint"> 
            <inout> 
                 <inout bind="txtEmpPK" /> 
					<inout bind="txtFCount" />
					<inout bind="txtFInfo" />
					<inout bind="txtFPText1" />
					<inout bind="txtFPText2" />
					<inout bind="txtFPText3" />
					<inout bind="txtFPText4" />
					
					<inout bind="txtMapping" />
					<inout bind="txtCard" />
					<inout bind="lstOption" />
					<inout bind="lstAdmin" />
					<inout bind="txt_user_status" />
					
                
             </inout>
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------->
<gw:data id="datEmployee_Detail_Search" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" function="HR_SEL_10070002_EMP_DETAIL" > 
                <inout>
                    <inout bind="txtEmpPK" /> 
					<inout bind="txtFCount" />
					<inout bind="txtFInfo" />
					<inout bind="txtFPText1" />
					<inout bind="txtFPText2" />
					<inout bind="txtFPText3" />
					<inout bind="txtFPText4" />
					<inout bind="txtCard" />
					<inout bind="lstOption" />
					<inout bind="lstAdmin" />
					
                    <inout bind="txtEmpID" /> 
                    <inout bind="txtIDNum" /> 
                    <inout bind="txtPhoto_PK" /> 
                    <inout bind="txtFullName" /> 
                    
                    <inout bind="txtCurAdd" /> 
                    <inout bind="txtPerAdd" /> 
                    <inout bind="txtOrganization" /> 
                    <inout bind="txtGroup" /> 
                    <inout bind="txtEmpType" /> 
                    <inout bind="txtTel" /> 
                    <inout bind="txtSex" /> 
                    <inout bind="txtStatus" /> 
                    <inout bind="txtJoinDate" /> 
                    <inout bind="txtLeftDate" /> 
                    <inout bind="txtNation" /> 
                    <inout bind="txtBirthPlace" /> 
                    <inout bind="txtBirthDate" /> 
                    <inout bind="txtPersonID" /> 
                    <inout bind="txtPersonIDPlace" /> 
                    <inout bind="txtIssuedDate" /> 
                    <inout bind="txtPos" /> 
                    <inout bind="txtJob" />
                    <inout bind="txtEdu" />
                    <inout bind="txtEthnic" />
                    <inout bind="txtReligion" />
                    <inout bind="txtMarital" />
					
					
					
                </inout> 
            </dso> 
        </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>
<gw:data id="datGroupMapping" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10070002_Group_Mapping" > 
                <input bind="grdMapping" >
                    <input bind="txtEmpPK" />
					<input bind="iduser_pk" />
					<input bind="txtOrg_tmp_pk" />
                </input>
                <output  bind="grdMapping" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datStatus" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10070002_Process_status" parameter="0,4,5,6,7" procedure="HR_UPD_10070002_Process_status"  > 
                <input bind="grdEmployee2" >
                    <input bind="txt_key" />
					
					
                </input>
                <output  bind="grdEmployee2" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGetBranch" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_branch"  > 
                <input>
                    <input bind="txtOrg_tmp_pk" />
					<input bind="iduser_pk" />
					
                </input> 
                <output>
                    <output bind="lstBranch" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:data id="datAccessGroup" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_AccessGroup"  > 
                <input>
                    <input bind="txtOrg_tmp_pk" />
					<input bind="lstBranch" />
					<input bind="iduser_pk" />
					
                </input> 
                <output>
                    <output bind="lstAccessGoup" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->

<!----------------------------------->
<table  border="1" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td  id="idLeftDiv" valign="top" width="40%" height="100%">
        
            <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 class="itable">
			    <tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle">Nation</td>
				    <td colspan=2 width="25%" style="border:0" >
					    <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by seq")%>|ALL|Select All</data></gw:list>
				    </td>
				    <td width="16%" align=right>Status</td>
				    <td colspan=3 width="44%"><gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by seq" )%>|ALL|Select All</data></gw:list>
                     </td>
				    <td width=5%></td>
				    <td width=5%></td>
			    </tr>
				
				 
				
				<tr style="border:0;height:5%">
			        <td style="border:0"  align="right" valign="middle"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
				    <td style="border:0" colspan=6>
					    <gw:list  id="lstOrg" value="ALL" styles='width:100%' onchange=""> 
					    <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
				    </td>
				    <td ></td>
				    <td ></td>
				    
				    
			    </tr>
				<tr  style="border:0;height:5%" >
					<td  style="border:0" align="right">Join DT</td>
				    <td colspan=2 style="border:0" ><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td ></td>
				    <td colspan=4 style="border:0" ><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td ></td>
				    <td ></td>
				    
				</tr>
				<tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle">Finger</td>
				    <td colspan=2 width="25%" style="border:0" >
					    <gw:list  id="lstFinger" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>|Y|YES|N|NO|ALL|Select All</data></gw:list>
				    </td>
				    <td width="16%" align=right><gw:list  id="lstBranch"  maxlen = "100" value='ALL' styles='width:100%' onchange="datAccessGroup.Call()" >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0217' ")%>|ALL|Branch- ALL
                </data>
            </gw:list></td>
				    <td colspan=3 width="44%">
					<gw:list  id="lstAccessGoup"  maxlen = "100" value='ALL' styles='width:100%' onchange="" >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0216' ")%>|ALL|Acess group- ALL
                </data>
            </gw:list>		
				   </td>
				    <td width=5%></td>
				    <td width=5%></td>
			    </tr>
				<tr  style="border:0;height:5%">
		            <td style="border:0" align="right" >Search by</td>
		            <td colspan=2 style="border:0">									
			            <gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list>
		            </td>
		            <td colspan=4 style="border:0"><gw:textbox id="txtTemp" styles="color:blue;width:100%"  onenterkey ="OnSearch()"  /></td>
		            <td colspan=2 style="border:0" align="left"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
		            
				</tr >
				
				
				<tr   style="border:1;height:5%">
			        
				    <td   style="border:1" align="left"><gw:checkbox id="chkSelect" value="F" onclick="OnSelectAll(chkSelect,grdEmployee)" >Select</gw:checkbox ></td>
				    
					<td align="center" colspan=2 style="border:0">
					<gw:icon id="btnDispaly"   text="View Processing" onclick="OnShowProcess()" />
		            </td>
					<td align="center" style="border:0;color:blue"><gw:label id="idInterval" styles="font-size:15pt;width:100%; color: blue" />
		            
		            
					<td  colspan=2 align="center" style="border:0" ><gw:icon id="btnSendDelete"   text="Delete on Terminal" onclick="OnShowTerminal(2)" /></td>
				    
					
					<td  colspan=3 align="right" style="border:0" ><gw:icon id="btnSend"   text="Send to Terminal" onclick="OnShowTerminal(1)" /></td>
				    </tr>
				
				
		        <tr  style="border:1;height:90%">
		            <td colspan=9 style="width:100%;height:100%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td>
		                            <gw:grid   
			                        id="grdEmployee"  
			                        header="_PK|V|Full Name|Emp ID|ID Num|Join DT|Finger Count|Card ID|Access Group|Remark|_status"
			                        format="0|3|0|0|0|4|0|0|0|0|0"  
			                        aligns="0|3|0|0|0|4|0|0|0|0|0"  
			                        defaults="||||||||||"  
			                        editcol="0|0|0|0|0|0|0"  
			                        widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"  
			                        styles="width:100%; height:100%"   
			                        sorting="T"   oncelldblclick ="OnClickRow()"
			                        param="0,1,2,3,4,5"   />
									
									<gw:grid   
			                        id="grdEmployee2"  
			                        header="PK|Full Name|Remark|_status|_listTerID|_branch|_Key|option"
			                        format="0|0|0|0|0|0|0|0"
			                        aligns="0|0|0|0|0|0|0|0"
			                        defaults="|||||||"
			                        editcol="0|0|0|0|0|0|0|0"
			                        widths="1000|1500|3000|1000|1000|1000|0|0"
			                        styles="width:100%; height:100%"   
			                        sorting="T"  
			                        param="0,5"   />
		                        </td>
		                    </tr>
		               </table>
		            </td>
		        </tr>
	        </table>
	    </td>     
        <td  id="idRightDiv" align="top" height="100%">
         
            <table  valign="top" border=0 cellpadding=0 cellspacing=0 width='100%' style="height:100%" > 
			    <tr style="height:5%" >
				    <td width="18%" align="right">Emp ID</td>
				    <td width="20%"> <gw:textbox id="txtEmpID"  enable="false" styles='width:100%;'  /></td>
				    <td width="15%"  align="right">Id Num</td>
				    <td width="17%"> <gw:textbox id="txtIDNum" styles='width:100%' /></td>
				    <td width="30%" style="border:0" colspan="2" rowspan="3" align="center">
					<gw:image id="imgFile" table="TC_FSBINARY" procedure="hr_insert_image_emp" 
                         view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx"  styles="width:100;height:100"  /> </td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right"> Full Name</td>
				    <td > <gw:textbox id="txtFullName"  styles='width:100%' /></td>
				    <td   align="right"></td>
				    <td > </td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right">Current Address</td>
				    <td colspan=3> <gw:textbox id="txtCurAdd"  styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td   align="right">Permanent Address</td>
				    <td colspan=3> <gw:textbox id="txtPerAdd"  styles='width:100%' /></td>
					<td align="right" width="15%"> Organization</td>
				    <td  width="15%" > <gw:textbox id="txtOrganization"  styles='width:100%' /></td>
			    </tr>
			    
				<tr style="height:5%" >
				    <td align="right">Finger count</td>
				    <td > <gw:textbox  id="txtFCount"  styles='width:100%' /></td>
				    <td   align="right">Finger Info </td>
				    <td> <gw:textbox   id="txtFInfo" styles='width:100%;'  /></td>
					<td   align="right">Work Group</td>
				    <td > <gw:textbox id="txtGroup" styles='width:100%' /></td>
			    </tr>
				
    			<tr style="height:5%" >
				    <td align="right"> Card ID</td>
				    <td > <gw:textbox id="txtCard"  styles='width:100%' /></td>
				    <td  align="right">Option</td>
				    <td > <gw:list  id="lstOption" value='1' maxlen = "100" styles='width:100%' >
                            <data>|1|Finger Print|4|Card</data></gw:list>
					</td>
					<td  align="right">Terminal Admin</td>
				    <td > <gw:list  id="lstAdmin" value='N' maxlen = "100" styles='width:100%' >
                            <data>|N|No|Y|Yes</data></gw:list>
					</td>
					
			    </tr>
				
				<tr style="height:1%" >
				<td colspan=6 align="left">
				<img status="collapse" id="img_temp" alt="Show Column" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle(1)"  />
				</td>
			    <tr id="r1" style="height:5%"   >
				    <td  align="right">Emp Type</td>
				    <td > <gw:textbox id="txtEmpType"  styles='width:100%' /></td>
				    <td   align="right">Tel</td>
				    <td > <gw:textbox id="txtTel" styles='width:100%' /></td>
				    <td width="15%"  align="right">Sex</td>
				    <td width="15%"> <gw:textbox id="txtSex" styles='width:100%' /></td>
			    </tr>
			    <tr id="r2" style="height:5%" >
				    <td align="right">Status</td>
				    <td > <gw:textbox id="txtStatus"  styles='width:100%' /></td>
				    <td   align="right">Join Date</td>
				    <td > <gw:textbox id="txtJoinDate" styles='width:100%' /></td>
				    <td   align="right">Left Date</td>
				    <td > <gw:textbox id="txtLeftDate" styles='width:100%' /></td>
			    </tr>
    			<tr id="r3" style="height:5%" >
				    <td  align="right">Nation</td>
				    <td > <gw:textbox id="txtNation"  styles='width:100%' /></td>
				    <td  align="right">Birth Place</td>
				    <td > <gw:textbox id="txtBirthPlace" styles='width:100%' /></td>
				    <td align="right">Birth Date</td>
				    <td > <gw:textbox id="txtBirthDate" styles='width:100%' /></td>
			    </tr>
			    <tr id="r4" style="height:5%">
				    <td align="right">Person ID</td>
				    <td> <gw:textbox id="txtPersonID"  styles='width:100%' /></td>
				    <td  align="right">Person ID Place</td>
				    <td > <gw:textbox id="txtPersonIDPlace" styles='width:100%' /></td>
				    <td align="right">Issued Date</td>
				    <td > <gw:textbox id="txtIssuedDate" styles='width:100%' /></td>
			    </tr>
			    <tr id="r5" style="height:5%" >
				    <td  align="right">Position</td>
				    <td > <gw:textbox id="txtPos"  styles='width:100%' /></td>
				    <td align="right">Job</td>
				    <td > <gw:textbox id="txtJob" styles='width:100%' /></td>
				    <td align="right">Education</td>
				    <td > <gw:textbox id="txtEdu" styles='width:100%' /></td>
			    </tr>
			    <tr id="r6" style="height:5%">
				    <td align="right">Ethnic</td>
				    <td > <gw:textbox id="txtEthnic"  styles='width:100%' /></td>
				    <td align="right">Religion</td>
				    <td > <gw:textbox id="txtReligion" styles='width:100%' /></td>
				    <td   align="right">Marital Status</td>
				    <td > <gw:textbox id="txtMarital" styles='width:100%' /></td>
			    </tr>
				
				
				
				<tr  style="height:5%">
				<td  colspan=4 align="left"  ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,grdMapping)" >Select</gw:checkbox ></td>
				<td  colspan=2 align="left"  ><gw:icon id="btnSave"   text="Update Data" onclick="onSave()" />
				</td>
				</tr>

			    <tr  style="height:30%" >
			        <td colspan=3 >
			          <table  name="Experience"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:99%;" >
					            <tr> 
					                <td   >
						                <gw:grid   
                                            id="grdMapping"  
                                            header="_code|Use|Branch|Access Group|Count Terminal"   
                                            format="0|3|0|0|0"   
                                            aligns="0|0|0|0|0"   
                                            defaults="||||"   
                                            editcol="0|0|0|0|0"   
                                            widths="1000|1000|1000|1000|1000"   
                                            styles="width:100%; height:100%"   
                                            sorting="T"   
                                            param="0,1,2,3,4" /> 
					                </td> 
					            </tr>
				            </table>    
					</td>
					<td colspan=3 >
					<table  border=1 style="height:100%" >
					<tr style="height:5%">
					<td align="center">
					<gw:icon id="btnEnroll"   text="Enroll" onclick="Enroll()" />
					</td>
					<td align="center">
					<gw:icon id="btnDelete"   text="Delete Finger" onclick="DeleteFinger()" />
					</td>
					</tr>
					<tr style="height:30%" >
					<td colspan=2>
					<div id="poup" style="width: :100%">
					  
							<div id = "title" style="float: left;text-align: center; ">Finger Info</div>
						
								<img alt="" src="" style="height:5%" id="imn1"> 
							
								<img alt="" src="" style="height:5%" id ="imn2">
						
								<img alt="" src="" style="height:5%" id ="imn3">
						
								<img alt="" src="" style="height:5%" id ="imn4">
							
								<img alt="" src="" style="height:5%" id ="imn5">
							
								<img alt="" src="" style="height:5%" id ="imn6">
							
								<img alt="" src="" style="height:5%" id ="imn7">
							
								<img alt="" src="" style="height:5%" id ="imn8">
							
								<img alt="" src="" style="height:5%" id ="imn9">
							
								<img alt="" src="" style="height:5%" id ="imn10">
									<img alt="" src="assets/finger_picture_10.gif" id ="imn11"  style="width:380px;">
							

						</div>
					</td>
					</tr>
					
					
					</table>
					
					</td>
			    </tr>
			</table> 
        </td>
    </tr>
</table>
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:0;top:0;" onclick="OnToggle(0)"  /> 
<gw:textbox id="txtEmpPK" styles="display:none"/>
<gw:textbox id="txtOrg" styles="display:none"/>	
<gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtFPText1" styles="display:none"/>
<gw:textbox id="txtFPText2" styles="display:none"/>
<gw:textbox id="txtFPText3" styles="display:none"/>
<gw:textbox id="txtFPText4" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="txtMapping" text="" styles="display:none"  />
<gw:textbox id="txt_user_status" text="" styles="display:none"  />
<gw:textbox id="txt_key" text="" styles="display:none"  />

</body>
</html>
