package service;

import persistence.model.Sales;
import persistence.model.user.User;
import persistence.repository.SalesRepository;

import java.sql.SQLException;
import java.util.List;

/**
 * The class contains logic for the "Sales" objects.
 */
public class SalesService {
    private final SalesRepository salesRepository;

    public SalesService() {
        salesRepository = new SalesRepository();
    }

    // Find all the sales from the system storage.
    public List<Sales> findSales(){
        try {
            return salesRepository.findSales();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    // Delete sales of the supplied user.
    public void deleteSalesByUser(User user){
        try {
            salesRepository.deleteSalesByUserId(user.getLoginId());
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
