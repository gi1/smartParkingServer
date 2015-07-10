/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.parking.controller;

import com.parking.managers.AgentsManager;
import com.parking.persistence.mongo.repositories.ParkingManagerRepository;
import com.parking.persistence.mongo.repositories.ParkingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

/**
 *
 * @author Marco Valentino
 */
@Controller
@RequestMapping(value = "/initController")
public class InitController {

    @Autowired
    ParkingRepository parkingRepo;

    @Autowired
    ParkingManagerRepository parkingManagerRepo;

    @RequestMapping(value = "/init")
    public @ResponseBody
    String init(WebRequest request) {

        AgentsManager.start();
        return "Agents successfully activated!";
    }

    @RequestMapping(value = "/restart")
    public @ResponseBody
    String restart(WebRequest request) {

        AgentsManager.restart();
        return "Agents successfully restarted!";
    }

}
