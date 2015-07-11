/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.parking.dbManager;

import com.parking.persistence.mongo.documents.Parking;
import com.parking.persistence.mongo.documents.ParkingManager;
import org.springframework.data.geo.GeoResults;

/**
 *
 * @author Marco Valentino
 */
public interface PersistenceManager {
    
    public Iterable<ParkingManager> getAllParkingManager();
    public GeoResults<Parking> findNearParking(double location[], double radius);
    public Iterable<Parking> getAllParking();
    public Iterable<Parking> getParkingByManager(String parkingManagerId);
    public void saveParking(Parking p);
    public void saveParkingManager(ParkingManager p);
    
}
