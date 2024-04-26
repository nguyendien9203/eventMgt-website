
package com.fpt.learning.model;

import java.sql.Timestamp;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;


@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User {
    int id;
    String fullname;
    String phone;
    String address;
    String gender;
    String username;
    String password;
    String role;
    String statusAttendees;
    Timestamp createdAt;
    Timestamp updateAt;
}


