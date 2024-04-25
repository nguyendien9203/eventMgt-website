package com.fpt.learning.model;

import java.sql.Timestamp;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Event {
    int id;
    String title;   
    String startDate;
    String endDate;
    String location;
    String description;
    List<User> attendees;
    Timestamp createdAt;
    Timestamp updatedAt;
}
