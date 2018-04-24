<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>

<script>
    var v_language = "<%=Session("SESSION_LANG")%>";

    var c_pk = 0,
        c_begin = 1,
        c_end = 2,
        c_wt = 3,
        c_ot = 4,
        c_nt = 5,
        c_shift = 6,
        c_start1 = 7,
        c_end1 = 8,
        c_hour1 = 9,
        c_start2 = 10,
        c_end2 = 11,
        c_hour2 = 12,
        c_start_ot = 13,
        c_start_nt = 14,
        c_use_yn = 15,
        c_description = 16,
        c_days = 17,
        c_wtplus = 18,
        c_maxot = 19,
        c_wtplus_rate = 20,
        c_com_pk = 21,
        c_reverse_ot_yn = 22,
        c_max_c_ot=23,
        c_note = 24;
		var dt_tmp;
		
    function BodyInit() {
        System.Translate(document);
        if (v_language != "ENG")
            System.Translate(document);
        iduser_pk.text = "<%=session("USER_PK")%>";
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    grdWorkShift.GetGridControl().FrozenCols = 4;
	grdWorkShift.GetGridControl().ColEditMask(c_begin)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_end)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_start1)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_end1)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_start2)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_end2)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_start_ot)="99:99";
	grdWorkShift.GetGridControl().ColEditMask(c_start_nt)="99:99";
    if ((Trim(iduser_pk.text) != "") && (txtHr_level.text == "1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();
    else
        ChangeLocation();
}
function OnDataReceive(obj) {
    if (obj.id == "datUser_info")
        datListWorkShift.Call("SELECT");
    else if (obj.id == "datFind_Report") {

        var url = System.RootURL + '/reports/ag/bh/' + txtReport_tmp.text + '?p_company=' + lstCompany.value;
        window.open(url);
    }
}
function ChangeLocation() {
    datListWorkShift.Call("SELECT");
}
function checkData() {
    var control = grdWorkShift.GetGridControl();
    var rows = control.Rows;
    var cols = control.Cols;
    var row = control.Row;
    var col = control.Col;

    for (j = 1; j < rows; j++) {
        var inTIME
        var outTIME
        inTIME = grdWorkShift.GetGridData(row, col);
		
        var inH1, inH2, inHH
        var inMM, inM1, inM2
        var inHHMM
        var dau

        if ((col == c_begin) || (col == c_end) || (col == c_start1) || (col == c_end1) || (col == c_start2) || (col == c_end2)) {
            			
			if (inTIME.length == 5) {

                inHH = inTIME.substr(0, 2);
                inH1 = inTIME.substr(0, 1);
                inH2 = inTIME.substr(1, 1);
                dau = inTIME.substr(2, 1);
                inMM = inTIME.substr(3, 2);
                inM1 = inTIME.substr(3, 1);
                inM2 = inTIME.substr(4, 1);

                if (dau == ":") {
                    //if (((parseInt(inH1)) && (parseInt(inH1))) && ((parseInt(inM2)) && (parseInt(inM1))))
                    if (((inH1 >= 0) && (inH2 >= 0)) && ((inM2 >= 0) && (inM1 >= 0))) {
                        if ((inHH >= 24) || (inMM >= 60)) {
                            alert("IN and OUT format HH:MM with HH < 24 and MM <60");
                            grdWorkShift.SetGridText(row, col, txtidSaveData.text);
                            return;
                        }
                    }
                    else {
                        alert("IN and OUT format HH:MM and IN and OUT must number with HH < 24 and MM <60");
                        grdWorkShift.SetGridText(row, col, txtidSaveData.text);
                        return;
                    }
                }
                else {
                    alert("IN and OUT format HH:MM and IN and OUT must number with HH < 24 and MM <60");
                    grdWorkShift.SetGridText(row, col, txtidSaveData.text);
                    return;
                }
            }
            else {
                alert("IN and OUT format HH:MM with HH < 24 and MM <60");
                grdWorkShift.SetGridText(row, col, txtidSaveData.text);
                return;
            }
        }

        if ((col == c_wt) || (col == c_ot) || (col == c_nt) || (col == c_shift)) {
            data = grdWorkShift.GetGridData(j, col);

            if (parseInt(data)) {
                if (data.length > 4) {
                    alert('Len of sting can not more than 2 character...');
                    grdWorkShift.SetGridText(j, col, txtidSaveData.text);
                    return;
                }

                else {
                    if (data.length < 1) {
                        alert('Len of sting can not more than 1 character...');
                        grdWorkShift.SetGridText(j, col, txtidSaveData.text);
                        return;
                    }

                }
            }
            else {

            }
            if (isNaN(data)) {
                alert('Can not empty string...');
                grdWorkShift.SetGridText(j, col, txtidSaveData.text);
                return;
            }
        }

    }

    if (col == c_end) {
        var outH1, outH2, outHH
        var outM1, outM2, outMM
        var outHHMM
        inTIME = grdWorkShift.GetGridData(row, c_begin);
        outTIME = grdWorkShift.GetGridData(row, c_end);

        inHH = inTIME.substr(0, 2);
        inH1 = inTIME.substr(0, 1);
        inH2 = inTIME.substr(1, 2);

        inMM = inTIME.substr(3, 5);
        inM1 = inTIME.substr(3, 4);
        inM2 = inTIME.substr(4, 5);

        inHHMM = inHH + inMM

        outHH = outTIME.substr(0, 2);
        outH1 = outTIME.substr(0, 1);
        outH2 = outTIME.substr(1, 2);

        outMM = outTIME.substr(3, 5);
        outM1 = outTIME.substr(3, 4);
        outM2 = outTIME.substr(4, 5);

        outHHMM = outHH + outMM

    }



    //Dim s_hour, s_min, e_hour, e_min, wt, ot, nt, shift, result, tmp
    var s_hour = new String;
    var e_hour = new String;

    var wt = new String;
    var ot = new String;
    var nt = new String;
    var shift = new String;


    var tmp_result = new String;
    txtidPK.text = grdWorkShift.GetGridData(row, c_pk);
    s_hour = grdWorkShift.GetGridData(row, c_begin);
    e_hour = grdWorkShift.GetGridData(row, c_end);
    wt = grdWorkShift.GetGridData(row, c_wt);
    ot = grdWorkShift.GetGridData(row, c_ot);
    nt = grdWorkShift.GetGridData(row, c_nt);
    shift = grdWorkShift.GetGridData(row, c_shift);
    start_lunch = grdWorkShift.GetGridData(row, c_start1);
    end_lunch = grdWorkShift.GetGridData(row, c_end1);
    start_dinner = grdWorkShift.GetGridData(row, c_start2);
    end_dinner = grdWorkShift.GetGridData(row, c_end2);
    start_ot = grdWorkShift.GetGridData(row, c_start_ot);

    if (s_hour < 10) {
        s_hour = "0" + s_hour
    }

    if (e_hour < 10) {
        e_hour = "0" + e_hour
    }


    tmp_result = s_hour + "-" + e_hour + "W" + wt + "O" + ot + "N" + nt + "S" + shift + "L" + start_lunch + "-" + end_lunch + "D" + start_dinner + "-" + end_dinner + "SOT" + start_ot;

    grdWorkShift.SetGridText(row, c_description, tmp_result);

    //Set this action to "edit" so that when a user click Update, it's only update the edited field.       
}
function AddOnClick() {
    grdWorkShift.AddRow();
    grdWorkShift.SetGridText(grdWorkShift.rows - 1, c_com_pk, lstCompany.value);
}


//Ms Van modify 

function CheckUpdate() {
    var rowvalue;
    for (var i = 1; i < grdWorkShift.rows; i++) {
        rowvalue = grdWorkShift.GetGridData(i, c_wt);
        if (isNaN(rowvalue)) //telephone
        {
            alert("Please input number in row " + i + " and column " + c_wt);
            return false;
        }
        rowvalue = grdWorkShift.GetGridData(i, c_ot); //person id

        if (isNaN(rowvalue)) {
            alert("Please input number in row " + i + " and column " + c_ot);
            return false;
        }
        rowvalue = grdWorkShift.GetGridData(i, c_nt); //person id

        if (isNaN(rowvalue)) {
            alert("Please input number in row " + i + " and column " + c_nt);
            return false;
        }
        rowvalue = grdWorkShift.GetGridData(i, c_shift); //person id

        if (isNaN(rowvalue)) {
            alert("Please input number in row " + i + " and column " + c_shift);
            return false;
        }

        rowvalue = grdWorkShift.GetGridData(i, c_hour1); //person id

        if (isNaN(rowvalue)) {
            alert("Please input number in row " + i + " and column " + c_hour1);
            return false;
        }

        rowvalue = grdWorkShift.GetGridData(i, c_hour2); //person id

        if (isNaN(rowvalue)) {
            alert("Please input number in row " + i + " and column " + c_hour2);
            return false;
        }
    }
    return true;
}
function UpdateOnClick() {
    if (CheckUpdate())
        if (confirm("do you want to save?"))
            datListWorkShift.Call();
}
function DeleteOnClick() {
    if (confirm("do you want to delte?"))
        grdWorkShift.DeleteRow();
}
function UnDeleteOnClick() {
    grdWorkShift.UnDeleteRow();
}
///////////////////////
function OnDataError(oData) {
    //alert(eval(oData).errmsg);
    if (eval(oData).errno == 20001) {
        alert("Database problem 1: " + eval(oData).errmsg);
    }
    else if (eval(oData).errno == 20002) {
        alert("Database problem 2: " + eval(oData).errmsg);
    }
    else if (eval(oData).errno > 0) {
        alert("Unexpected error: " + eval(oData).errmsg);
    }

}
//--------------------------------------------------
function ReportOnClick() {
    txtReport_tmp.text = "rpt_shift_plan.aspx";
    datFind_Report.Call();

}
function On_AfterEdit()
{
	var control = grdWorkShift.GetGridControl();
    var rows = control.Rows;
    var cols = control.Cols;
    var row = control.Row;
    var col = control.Col;
	var tmpIN;
	cIdx=event.col;
///	ws=grdWorkShift.GetGridData(event.row,c_ws)
//	lstWS_temp.value=ws;
//	idlbWS.text=lstWS_temp.GetText();

	if (cIdx==c_begin)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
		//	alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			
		}
		*/		
	}	
	if (cIdx==c_end)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			
		}
		*/
		
	}	
	if (cIdx==c_start1)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		}
		if (cIdx==c_end1)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		
		}
		if (cIdx==c_start2)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		}
		if (cIdx==c_end2)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		}
		if (cIdx==c_start_ot)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		}
		if (cIdx==c_start_nt)
	{
	    tmpIN=grdWorkShift.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			grdWorkShift.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWorkShift.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)
			//alert(tmpIN);
		}
		// Set Columm WT khi edit
		/*
		if(tmpIN!=dt_tmp)
		{
		    grdWorkShift.SetGridText(event.row,c_wt,"")
		    grdWorkShift.SetGridText(event.row,cIdx,tmpIN)			
		}
		*/
		
		
	}
//Dim s_hour, s_min, e_hour, e_min, wt, ot, nt, shift, result, tmp
    var s_hour = new String;
    var e_hour = new String;

    var wt = new String;
    var ot = new String;
    var nt = new String;
    var shift = new String;


    var tmp_result = new String;
    txtidPK.text = grdWorkShift.GetGridData(row, c_pk);
    s_hour = grdWorkShift.GetGridData(row, c_begin);
    e_hour = grdWorkShift.GetGridData(row, c_end);
    wt = grdWorkShift.GetGridData(row, c_wt);
    ot = grdWorkShift.GetGridData(row, c_ot);
    nt = grdWorkShift.GetGridData(row, c_nt);
    shift = grdWorkShift.GetGridData(row, c_shift);
    start_lunch = grdWorkShift.GetGridData(row, c_start1);
    end_lunch = grdWorkShift.GetGridData(row, c_end1);
    start_dinner = grdWorkShift.GetGridData(row, c_start2);
    end_dinner = grdWorkShift.GetGridData(row, c_end2);
    start_ot = grdWorkShift.GetGridData(row, c_start_ot);

    if (s_hour < 10) {
        s_hour = "0" + s_hour
    }

    if (e_hour < 10) {
        e_hour = "0" + e_hour
    }


    tmp_result = s_hour + "-" + e_hour + "W" + wt + "O" + ot + "N" + nt + "S" + shift + "L" + start_lunch + "-" + end_lunch + "D" + start_dinner + "-" + end_dinner + "SOT" + start_ot;

    grdWorkShift.SetGridText(row, c_description, tmp_result);

    //Set this action to "edit" so that when a user click Update, it's only update the edited field. 	


}
function On_click()
{
    var ws;
	dt_tmp=grdWorkShift.GetGridData(event.row,event.col)//luu tru gia tri vua click
	//ws=grdWorkShift.GetGridData(event.row,c_ws)
	//lstWS_temp.value=ws;
	//idlbWS.text=lstWS_temp.GetText();
	
}
</script>
<body>
    <gw:data id="datListWorkShift"   onerror="OnDataError(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24" function="HR_SEL_80020020_WS" procedure="HR_UPD_80020020_WS"> 
                <input bind="grdWorkShift"  > 
                   <input bind="lstCompany" />                 
                </input>
                <output bind="grdWorkShift" > 
                </output>
            </dso> 
            
        </xml> 
    </gw:data> 
 <!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="lstCompany" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_company_user"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstCompany" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <table border=1 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
        <tr style="height:5%">
        <td align=center style="width:100%">
            <table border=0 style="width:100%" cellpadding =0 cellspacing=0>
                <td style="color:Red;font-size:larger"align=right>Company</td>
                <td style="color:Red;font-size:larger; width:76%"><gw:list  id="lstCompany"  maxlen = "100" styles='width:70%'onchange="ChangeLocation()" >
                            <data>
                                <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                            </data>
                        </gw:list></td>
                <td width="4%" align=right><gw:imgBtn img="new"     alt="new"      id="ibtnAdd" 	onclick="AddOnClick()" /></td>					
			    <td width="4%" align=right><gw:imgBtn img="delete"  alt="delete"   id="ibtnDelete" 	onclick="DeleteOnClick()" /></td>  
			    <td width="4%" align=right><gw:imgBtn img="udelete" alt="undelete" id="ibtnDelete1" onclick="UnDeleteOnClick()" /></td> 
			    <td width="4%" align=right><gw:imgBtn img="save"    alt="save"     id="ibtnUpdate"  onclick="UpdateOnClick()"/></td>
                <td width="4%" align=right><gw:imgBtn img="excel"    alt="report"     id="ibtnReport"  onclick="ReportOnClick()"/></td>
			</table>
		</td>
        </tr>
        <tr style="height:95%">
            <td style="width:100%">
                <gw:grid   
					id="grdWorkShift"  
					header="_PK|Begin|End|WT|OT|NT|Shift|Start (1)|End (1)|Hour (1)|Start (2)|End (2)|Hour (2)|Start OT|Start NT|Use|Description|Days|WT Plus|Max OT|WT Plus Rate|_company_pk|Reverse OT|Max Reverse OT|Note"   
					format="0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|3|0|0|0|0|2|0|0|0|0"  
					aligns="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|0|1|0|0"  
					defaults="|||||||||||||||-1||||||||"  
					editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1"  
					widths="0|800|800|500|500|500|500|1000|1000|800|1000|1000|800|1200|1200|600|6000|500|1000|1000|1000|0|1000|1000|2000"  
					styles="width:100%; height:100%;border:1"   
					sorting="T" 		
					onafteredit="On_AfterEdit()"					
					oncelldblclick="checkData()"		
					onentercell = "On_click()"	/>									
            </td>
        </tr>
    </table>
    <gw:textbox id="txtidPK"  		text=""  style="display:none"/>  
    <gw:textbox id="txtidSaveData" 	text=""  style="display:none"/> 
    <gw:textbox id="txtAction" 	    text=""  style="display:none"/> 
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtUser_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
</body>
</html>
