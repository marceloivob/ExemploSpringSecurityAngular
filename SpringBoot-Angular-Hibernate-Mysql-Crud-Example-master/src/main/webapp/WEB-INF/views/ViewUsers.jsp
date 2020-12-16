<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : ViewUsers
    Created on : Sep 21, 2017, 9:13:33 PM
    Author     : k0712
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>


<!DOCTYPE>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <c:set var="context" value="${pageContext.request.contextPath}"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>JSP Page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/imask"></script>
    <script>
        var context = '${context}';
    </script>
        <!-- Adicionando Javascript -->
        <script>

            function limpa_formulário_cep() {
            //Limpa valores do formulário de cep.
            document.getElementById('rua').value=("");
            document.getElementById('bairro').value=("");
            document.getElementById('cidade').value=("");
            document.getElementById('uf').value=("");

        }

            function meu_callback(conteudo) {
            if (!("erro" in conteudo)) {
            //Atualiza os campos com os valores.

            document.getElementById('rua').value=(conteudo.logradouro);
            document.getElementById('bairro').value=(conteudo.bairro);
            document.getElementById('cidade').value=(conteudo.localidade);
            document.getElementById('uf').value=(conteudo.uf);
        } //end if.
            else {
            //CEP não Encontrado.
            limpa_formulário_cep();
            alert("CEP não encontrado.");
        }
        }

            function pesquisacep(valor) {

            //Nova variável "cep" somente com dígitos.
            var cep = valor.replace(/\D/g, '');

            //Verifica se campo cep possui valor informado.
            if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {

            //Preenche os campos com "..." enquanto consulta webservice.
            document.getElementById('rua').value="...";
            document.getElementById('bairro').value="...";
            document.getElementById('cidade').value="...";
            document.getElementById('uf').value="...";


            //Cria um elemento javascript.
            var script = document.createElement('script');

            //Sincroniza com o callback.
            script.src = 'https://viacep.com.br/ws/'+ cep + '/json/?callback=meu_callback';

            //Insere script no documento e carrega o conteúdo.
            document.body.appendChild(script);

        } //end if.
            else {
            //cep é inválido.
            limpa_formulário_cep();
            alert("Formato de CEP inválido.");
        }
        } //end if.
            else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
        }
        };

    </script>

</head>
<body>

<div class="container" ng-app="sample" ng-controller="viewUserController as vController" ng-init="beforeLoad()">
    <h2>Sample Spring Boot Application</h2>
    <div class="panel panel-default">
        <div class="panel-heading"><h2>View Users</h2></div>

        <div class="panel-body">
            <a data-toggle="modal" data-target="#addUser" class="pull-right btn btn-sm btn-success"> + Add New User </a>
            <table class="table">
                <thead>
                <tr>
                    <th>Count</th>
                    <th>Username</th>
                    <th>CPF</th>
                    <th>Cep</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                <tr ng-repeat="user in users">
                    <td>{{$index+1}}</td>
                    <td>{{user.username}}</td>
                    <td>{{user.cpf}}</td>
                    <td>{{user.cep}}</td>
                    <td>
                        <a class="btn btn-success btn-sm" ng-click="viewUser.getAllUserContact(user.userId,user.username)">View
                        Contacts</a>
                        <a class="btn btn-danger btn-sm" ng-click="deleteUser.delete(user.userId,user.username)">Delete</a>
                    </td>
                </tr>
                </tr>
                </tbody>
            </table>
            <br>

            <div class="row">
                <center>
                    <h3>{{userDec}}</h3>
                    <table class="table" ng-if="contacts != null">
                        <thead>
                        <tr>
                            <th>Contact Count</th>
                            <th>Contact</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="contact in contacts">
                            <td>{{$index+1}}</td>
                            <td>{{ contact.contact }}</td>
                        </tr>
                        </tbody>
                    </table>
                </center>
            </div>


        </div>


        <!-- Modal -->
        <div class="modal fade" id="addUser" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header bg-success">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New User</h4>
                    </div>
                    <div class="modal-body">
                        <h2>User Basic Details</h2>
                        <form ng-submit="addUser.addUser()">
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" ng-model="user.username" required class="form-control" id="username">
                            </div>
                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input type="password" ng-model="user.password" required class="form-control" id="pwd">
                            </div>
                            <div class="form-group">
                                <label for="cpf">CPF:</label>
                                <input ng-model="user.cpf" required class="form-control" id="cpf" type="text" placeholder="digite o CPF"><span id="resposta"></span>
                            </div>
                            <div class="form-group">
                                <label for="cep">Cep:</label>
                                    <input ng-model="user.cep" name="cep" class="form-control" type="text" id="cep" value="" size="10" maxlength="10" onblur="pesquisacep(this.value);" />
                            </div>
                            <div class="form-group">
                                <label for="rua">Rua:</label>
                                    <input ng-model="user.rua" required name="rua" class="form-control" type="text" id="rua" value="" size="60" />
                            </div>
                                <div class="form-group">
                                <label for="bairro">Bairro:</label>
                                    <input ng-model="user.bairro" required name="bairro" class="form-control" type="text" id="bairro" size="40" />
                                </div>
                                    <div class="form-group">
                                    <label for="cidade">Cidade:</label>
                                    <input ng-model="user.cidade" required name="cidade" class="form-control" type="text" id="cidade" size="40" />
                                    </div>
                                        <div class="form-group">
                                        <label for="uf">Estado:</label>
                                    <input ng-model="user.uf" required name="uf" class="form-control" type="text" id="uf" size="2" />
                                        </div>

                            <h2>User Contacts</h2>
                            <div ng-repeat="contact in user.sampleContactCollection">

                                <div class="form-group">
                                    <label>Contact {{$index+1}} <a class="btn btn-danger btn-sm "
                                                                   ng-click="addUser.removeContact($index)">x</a></label>
                                    <input type="text" ng-model="contact.contact" required class="form-control">
                                    <br>
                                </div>

                            </div>
                            <a class="btn btn-warning pull-right " ng-click="addUser.addContactToUser()">+ Contact</a>
                            <br>
                            <br>

                            <button type="submit" class="pull-right btn btn-default">Submit</button>
                            <br>
                            <br>
                        </form>

                        <form method="get" action=".">

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
<script>

    $("#cep").blur(function(){
        pesquisacep($(this).val());
    });
    var maskCep = IMask(document.getElementById('cep'), {
        mask:[
            {
                mask: '00.000-000',
                maxLength: 8
            }
        ]
    });
    function CPF(){"user_strict";
    function r(r){
        for(
            var t=null,n=0;9>n;++n)t+=r.toString().charAt(n)*(10-n);
            var i=t%11;return i=2>i?0:11-i}
        function t(r){
        for(
            var t=null,n=0;10>n;++n)t+=r.toString().charAt(n)*(11-n);
            var i=t%11;return i=2>i?0:11-i}
            var n="CPF Inválido",i="CPF Válido";
            this.gera=function(){
                for(
                    var n="",i=0;9>i;++i)n+=Math.floor(9*Math.random())+"";
                    var o=r(n),a=n+"-"+o+t(n+""+o);
                    return a},this.valida=function(o){
                        for(var a=o.replace(/\D/g,""),u=a.substring(0,9),f=a.substring(9,11),v=0;10>v;v++)
                            if(""+u+f==""+v+v+v+v+v+v+v+v+v+v+v)
                                return n;
                                    var c=r(u),e=t(u+""+c);
                                      return f.toString()===c.toString()+e.toString()?i:n}}



    var CPF = new CPF();
    for(var i =0;i<40;i++) {
        var temp_cpf = CPF.gera();
    }

    $("#cpf").keypress(function(){
        $("#resposta").html(CPF.valida($(this).val()));
    });

    $("#cpf").blur(function(){
        $("#resposta").html(CPF.valida($(this).val()));
    });

    var maskCpf = IMask(document.getElementById('cpf'), {
        mask:[
            {
                mask: '000.000.000-00',
                maxLength: 11
            }
        ]
    });
    var sample = angular.module('sample', []);
    sample.controller('viewUserController', ['$scope', '$http', function ($scope, $http) {

        $scope.users, $scope.userDec, $scope.contacts = null;
        $scope.user = {
            sampleContactCollection: [
                {
                    contact: null,
                }
            ]
        };
        $scope.beforeLoad = function () {
            $scope.viewUser.getAllUsers();
        }
        $scope.viewUser = {
            getAllUsers: function () {
                $http({
                    method: 'GET',
                    url: context + '/user/get',
                }).then(function successCallback(response) {
                    if (response.status == 400) {
                        alert('Users Not Found');
                    } else if (response.status == 200) {
                        $scope.users = response.data;
                    }
                }, function errorCallback(response) {
                    alert(JSON.stringify(response));
                });
            },
            getAllUserContact: function (id, name) {
                $http({
                    method: 'GET',
                    url: context + '/user/get/contact',
                    params: {userId: id}
                }).then(function successCallback(response) {
                    if (response.status == 204) {
                        $scope.userDec = name + "'s Contacts Not Available";
                        $scope.contacts = null;
                    } else if (response.status == 200) {
                        $scope.userDec = name + "'s Contacts";
                        $scope.contacts = response.data;
                    }
                }, function errorCallback(response) {
                    alert(JSON.stringify(response));
                });
            }
        }

        $scope.addUser = {
            addUser: function () {
                if(document.getElementById('resposta').innerHTML=="CPF Inválido"){
                  alert('CPF Inválido');
                  return;
                }

                $http({

                    method: 'POST',
                    url: context + '/user/add',
                    data : $scope.user

                }).then(function successCallback(response) {
                    if (response.status == 204) {

                    } else if (response.status == 200) {
                        $scope.user = {
                            sampleContactCollection: [
                                {
                                    contact: null,
                                }
                            ]
                        };
                        alert(response.data.message);
                        $scope.viewUser.getAllUsers();
                    }
                }, function errorCallback(response) {
                    if(response.status == 403){
                        alert("User not admin");
                        return;
                    }else {
                        alert(JSON.stringify(response));
                    }
                });

            },
            addContactToUser: function () {
                $scope.user.sampleContactCollection.push(
                        {
                            contact: null,
                        }
                );
            },
            removeContact: function (index) {
                $scope.user.sampleContactCollection.splice(index, 1);
            }
        }

        $scope.deleteUser = {
            delete: function (id,username) {

                $http({
                    method: 'DELETE',
                    url: context + '/user/delete/'+id
                }).then(function successCallback(response) {
                    if (response.status == 204) {
                        //fail message
                    } else if (response.status == 200) {
                        alert(username+' '+response.data.message);
                        $scope.viewUser.getAllUsers();
                    }
                }, function errorCallback(response) {
                    alert(JSON.stringify(response));
                });

            }
        }


    }])
    ;
</script>

</body>
</html>

