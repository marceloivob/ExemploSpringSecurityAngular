/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sample.entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author k0712
 */
@Entity
@Table(name = "sample_user")
@XmlRootElement
@NamedQueries({
        @NamedQuery(name = "SampleUser.findAll", query = "SELECT s FROM SampleUser s")})
public class SampleUser implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "user_id")
    private Integer userId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "username")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "password")
    private String password;
    @Size(max = 15)
    @NotNull
    @Column(name = "cpf")
    private String cpf;
    @Size(max = 10)
    @NotNull
    @Column(name = "cep")
    private String cep;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "userId",fetch = FetchType.LAZY)
    private List<SampleContact> sampleContactCollection;


    public SampleUser(){

    }
    public SampleUser(Integer userId, String username, String password, String cpf, String cep) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.cpf = cpf;
        this.cep = cep;
       // this.bairro = bairro;
        //this.cidade = cidade;
        //this.uf = uf;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

/**
    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }
*/
    @XmlTransient
    public List<SampleContact> getSampleContactCollection() {
        return sampleContactCollection;
    }

    public void setSampleContactCollection(List<SampleContact> sampleContactCollection) {
        this.sampleContactCollection = sampleContactCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userId != null ? userId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SampleUser)) {
            return false;
        }
        SampleUser other = (SampleUser) object;
        if ((this.userId == null && other.userId != null) || (this.userId != null && !this.userId.equals(other.userId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.sample.entity.SampleUser[ userId=" + userId + " ]";
    }

}
