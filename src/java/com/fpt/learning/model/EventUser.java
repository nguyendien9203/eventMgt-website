
package com.fpt.learning.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EventUser {
    int eventId;
    int userId;
    String role;
    String status;
}
