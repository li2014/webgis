<%@ page language="java" pageEncoding="UTF-8"%>
<!--分页查询共用的页面-->
<%@ include file="/common/paginateUtil.jsp"%>

</head>

<script type="text/javascript" charset="utf-8">
			//删除表格的某一行，删除后，会自动刷新表格			
			function getDeleteActionColumn(value, rowData, rowIndex)
			{  
				var entityId = rowData.funcId;
				var html =  "<img style='cursor: pointer;' src='<%=imgPath%>/cross.gif' onclick=\"Utility.deleteEntity('deleteFunc.action','" +entityId+"');\"/>";
				return html;
			}
			//编辑列
			function getEditActionColumn(value, rowData, rowIndex)
			{
				var entityId = rowData.funcId;
				var html =  "<a href=\"javascript:InfoWindow.editFuncInfo('" + entityId+ "');\">" +" 编辑</a>";
				return html;

			}
			

			$(document).ready(function() {
			      //对应数据库SQL查询的字段名
                  $("#parentId").lookup({queryID:"selectRootMenus"});
		          $("#funcType").lookup({category:"FunctionType", selectedValue:"${entity.funcType}"});//终端类型
				  //此方法有命名约定，表单ID是queryForm, 
				  //表格ID是dataTable,
                  //查询按钮的ID是btnQuery
				  // 严格区分大小写,
			      //Utility.initTable(columns, "<%=ApplicationPath%>/system/functionInfoList.action");
				  
				$("#btnQuery").click(function(){
				        Utility.loadGridWithParams();
				});

				
				Utility.loadGridWithParams();
			} );
		</script>
<body style="">
	<div id="toolbar">
		<form id="queryForm"
			action="<%=ApplicationPath%>/system/functionInfoList.action">
			<input type="hidden" name="queryId" value="selectFuncInfos" /> <input
				type="hidden" name="fileName" value="权限信息" />
			<table width="100%" class="TableBlock">
				<tr>
					<td>权限名称:</td>
					<td><input type="text" name="descr" size="10" id="descr">
					</td>
					<td align=right>权限类型:</td>
					<td align="left"><select name="funcType" id="funcType"
						style="width:150px">
					</select></td>
					<td align="right">上级菜单:</td>
					<td align="left"><select id="parentId" style="width: 150px;"
						name="parentId">
					</select></td>

					<td align="left"><a id="btnQuery" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>&nbsp;
						<a id="btnReset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-clear'">重置</a>&nbsp; <a id="btnNew"
						href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add'"
						onclick="InfoWindow.editFuncInfo(0);">新增</a>&nbsp;</td>
				</tr>
			</table>
		</form>
	</div>

	<table id="queryGrid" class="easyui-datagrid"
		data-options="pagination:true,pageSize:15,singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						pageList: [15, 20, 50, 100, 150, 200],fit:true,toolbar:'#toolbar',
						url:'<%=ApplicationPath%>/system/functionInfoList.action',method:'post'">
		<thead>
			<tr>
				<th data-options="field:'descr'" width="14%">名称</th>
				<th data-options="field:'funcType'" width="11%">菜单类型</th>
				<th data-options="field:'parentName'" width="8%">上级菜单</th>
				<th data-options="field:'url',align:'left'" width="23%">URL地址</th>
				<th data-options="field:'icon'" width="8%">css图标</th>
				<th data-options="field:'name'" width="9%">编码</th>
				<th data-options="field:'menuSort',align:'center'" width="5%">排序值</th>
				<th data-options="field:'createDate',align:'center'" width="12%">创建日期</th>
				<th data-options="field:'1',formatter:getEditActionColumn"
					width="5%">编辑</th>
				<th data-options="field:'2',formatter:getDeleteActionColumn"
					width="5%">删除</th>
			</tr>
		</thead>
	</table>

</body>

