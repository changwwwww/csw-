<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/8/28
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .dropdown-submenu {
        position: relative;
    }

    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }

    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }

    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }

    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }

    .dropdown-submenu.pull-left {
        float: none;
    }

    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
    }
</style>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
           <%-- <ul class="nav navbar-nav" >

            </ul>--%>
            <div id="nav"></div>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎${u.userName}登陆</a></li>
                <li><a href="#">今天是第${u.loginCount}次登录</a></li>
               <c:if test="${!empty  u.loginTime}" >
                    <li><a href="#">上次登陆的日期为<fmt:formatDate value="${u.loginTime}" pattern="yyyy-MM-dd"></fmt:formatDate></a></li>
               </c:if>
                <li><a href="/user/loginOut.csw">退出</a></li>
                <li><a href="/user/toUpdatePassword.csw">修改密码</a></li>
                <li><img src="${u.imgPath}"  style="border-radius:200px" width="50px">头像</li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
    </nav>
</div>
<div style="padding: 30px"></div>
<script type="text/javascript" src="/js/jquery-3.3.1.min.js" ></script>


<script>

   $(function () {
         $.ajaxSetup({
              complete:function (result) {
              var data= result.responseJSON;
                  if(data.code&&data.code!=200){
                      bootbox.alert({
                          size: "small",
                          message:data.msg,
                          //刷新
                      })
                  }
              }
          })
        queryMenu();

    })
    //声明全局变量
    var  menuArr;
    //发送ajax取出查询出来的集合
    function queryMenu() {
         $.ajax({
             url:"/menu/queryUserMenu.csw",
             type:"post",
             dataType:"json",
             success:function (result) {
                 if(result.code==200){
                     menuArr=result.data;
                         biludMenu(1,1);
                 console.log(menuArr)
                 }
             },
             error:function () {
                 alert("失败")
             }
         })

    }


   /*        function initMenu() {
               //获取顶级菜单
              var v_menuHtml=getMenuHtml();
              //顶级菜单js转为jQuery
              var  v_menuObj =$(v_menuHtml)
               console.log(v_menuHtml)
            //获取顶级菜单的id集合
           var v_menuIdArr = getTopMenuId();
              //循环顶级菜单的id
           for(var i=0;i<v_menuIdArr.length;i++){
               //调用获取子类id的方法
           var v_chidrenArr   = getChildren(v_menuIdArr[i]);
           //判断 子类数组里的值 是否大于0  大余0的话就进行拼接
                if(v_chidrenArr.length>0){
                    //添加属性
                    v_menuObj.find("a[data-id='"+v_menuIdArr[i]+"']").attr("data-toggle","dropdown");
                    //追加span
                    v_menuObj.find("a[data-id='"+v_menuIdArr[i]+"']").append('<span class="caret"></span>');

                    //构建子级
                var v_chidrenHtml= bulidChildren(v_chidrenArr);
                   //把子级id追加上去
                    v_menuObj.find("a[data-id='"+v_menuIdArr[i]+"']").parent().append(v_chidrenHtml)

                }
            }
              console.log(v_menuObj)
              //通过id填充
             $("#navTable").html(v_menuObj);
          }
  //查询顶级菜单
  function getMenuHtml() {
      var menuHtml="";
      //循环查询出来的集合 判断pid=1的 就是 顶级菜单
      for (var i=0;i< menuArr.length;i++) {
          if(menuArr[i].pId==1){
              //拼接字符串
           menuHtml+=' <li class="active"><a href="'+menuArr[i].url+'"  data-id='+menuArr[i].id+'>'+menuArr[i].menuName+' <span class="sr-only">(current)</span></a></li>'
          }
      }
      //返回拼接好的字符串
      return menuHtml;
  }
 //查询顶级菜单的id
   function getTopMenuId() {
       var menuId=[];
       //循环查询出来的集合 将pid=1的 对象放入 数组中
       for (var i=0;i< menuArr.length;i++) {
           if(menuArr[i].pId==1){
               menuId.push(menuArr[i].id);
           }
       }
       return menuId;
   }

    //获取子Id的数组
   function getChildren(id) {
       var childrenArr=[];
       //循环查询出来的集合  判断 pid
       for (var i = 0; i < menuArr.length; i++) {
           if (menuArr[i].pId == id) {
               childrenArr.push(menuArr[i]);
           }
       }
       //返回子类id的数组
       return childrenArr;
   }
    //构建子级
   function bulidChildren(childs) {
      //拼接字符串
      var result=' <ul class="dropdown-menu">';
      //循环子类对象
      for(var i=0;i<childs.length;i++){
          result+='  <li><a href="'+childs[i].url+'">'+childs[i].menuName+'</a></li>'
      }
       result+="</ul>";
      //拼接 返回字符串
      return result;
   }*/


  /*var v_html="";
  function biludMenu(id,level){
      console.log(level)
      //获取顶级id
      var v_menuIdArr=initChildren(id);

      console.log(v_menuIdArr)
      if(v_menuIdArr.length>0){

          if(level==1){
              v_html+='<ul class="nav navbar-nav">';
          }else {
              v_html+='<ul class="dropdown-menu">';
          }

          for(var i=0;i<v_menuIdArr.length;i++){
              var v_hasChildren=hasChildren(v_menuIdArr[i].id)
              v_menuIdArr[i].level=level;
              if(level==1){
                  if(v_hasChildren){
                      v_html +='<li><a href="'+v_menuIdArr[i].url+'" data-toggle="dropdown">'+v_menuIdArr[i].menuName+'<span class="caret"></span></a>'
                  }else {
                      v_html +='<li><a href="'+v_menuIdArr[i].url+'">'+v_menuIdArr[i].menuName+'</a>'
                  }
              }else {
                  if(v_hasChildren){
                      v_html+='<li class="dropdown-submenu"><a href="\'+v_menuIdArr[i].url+\'">'+v_menuIdArr[i].menuName+'</a>'
                  }else {
                      v_html+='<li><a href="'+v_menuIdArr[i].url+'">'+v_menuIdArr[i].menuName+'</a>'
                  }

              }
              biludMenu(v_menuIdArr[i].id,level+1);
              v_html+='</li>'
          }
          v_html+='</ul>';

      }
       $("#nav").html(v_html);
  }


  function initChildren(id){
      var menuIdArr=[];
      for(var i=0;i<menuArr.length;i++){
          if(menuArr[i].pId==id){
              menuIdArr.push(menuArr[i])
          }

      }
      return menuIdArr;
  }

  function hasChildren(id) {
      for(var i=0;i<menuArr.length;i++){
          if(menuArr[i].pId==id){
                return true;
          }

      }
      return false;
  }*/

       var v_html="";
    function biludMenu(id,level) {
        var v_childrenArr=initMenu(id);
        if(v_childrenArr.length>0){
            if(v_childrenArr.length>0){

                if(level==1){
                    v_html+='<ul class="nav navbar-nav">';
                }else {
                    v_html+='<ul class="dropdown-menu">';
                }

                for (var i=0;i<v_childrenArr.length;i++){
                    var v_hasChildren=hasChildren(v_childrenArr[i].id)

                    /*v_childrenArr[i].level=level;*/
                    if(level==1){
                        if(v_hasChildren){
                            v_html +='<li><a href="'+v_childrenArr[i].url+'" data-toggle="dropdown">'+v_childrenArr[i].menuName+'<span class="caret"></span></a>'
                        }else {
                            v_html +='<li><a href="'+v_childrenArr[i].url+'">'+v_childrenArr[i].menuName+'</a>'
                        }
                    }else {
                        if(v_hasChildren){
                            v_html+='<li class="dropdown-submenu"><a href="#">'+v_childrenArr[i].menuName+'</a>'
                        }else {
                            v_html+='<li><a href="'+v_childrenArr[i].url+'">'+v_childrenArr[i].menuName+'</a>'
                        }

                    }
                    biludMenu(v_childrenArr[i].id,level+1);
                }

                v_html+='</li>'
            }
            v_html+='</ul>';

        }
        $("#nav").html(v_html)
    }

    function initMenu(id) {
        var childrenArr=[];
        for (var i=0;i<menuArr.length;i++){
            if(menuArr[i].pId==id){
                childrenArr.push(menuArr[i])
            }
        }
        return childrenArr;
    }

    function hasChildren(id) {
        for (var i=0;i<menuArr.length;i++){
            if(menuArr[i].pId==id){
                return true;
            }
        }
        return false;
    }
</script>