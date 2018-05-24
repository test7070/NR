<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "tre_s";
			aPop = new Array(
		    ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx'], 
             ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
             , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno', 'tgg_b.aspx']);
			function z_tre() {
			}
            z_tre.prototype = {
                carteam : ''
            };
            var t_data = new z_tre();

            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    default:
                        break;
                }
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_driverno = $('#txtDriverno').val();
                t_driver = $.trim($('#txtDriver').val());
                t_carno = $('#txtCarno').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_accno = $.trim($('#txtAccno').val());
				t_tranno = $.trim($('#txtTranno').val());
				t_tggno = $.trim($('#txtTggno').val());
				
                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("driverno", t_driverno) 
                + q_sqlPara2("carno", t_carno) 
                + q_sqlPara2("datea", t_bdate, t_edate)
                + q_sqlPara_or(["accno", "accno2"], t_accno)
                + q_sqlPara2("tggno", t_tggno) ;
                if (t_driver.length > 0)
                    t_where += " and charindex('" + t_driver + "',driver)>0";     
				if(t_tranno.length>0)
		       		t_where += " and exists(select view_tres"+r_accy+".noa from view_tres"+r_accy+" where view_tres"+r_accy+".noa=view_tre"+r_accy+".noa and view_tres"+r_accy+".tranno='"+t_tranno+"')";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriverno'></a></td>
					<td>
					<input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
					<td>
					<input class="txt" id="txtDriver" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:90px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTranno'></a></td>
					<td>
					<input class="txt" id="txtTranno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'></a></td>
					<td>
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">廠商</td>
                    <td>
                    <input class="txt" id="txtTggno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>