package com.sample.dto.user;

/**
 * Created by Tharindu Kalhara on 9/21/2017.
 */
public class ViewUserDto {
    private Integer userId;
    private String username;
    private String cpf;
    private String cep;

    public ViewUserDto() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

}
