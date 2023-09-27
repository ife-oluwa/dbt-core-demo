<!-- @format -->

{% docs orders_status %}

Orders can be one of the following statuses:

| status         | description                                                                                                            |
| -------------- | ---------------------------------------------------------------------------------------------------------------------- |
| placed         | The order has been placed but has not yet left the warehouse.                                                          |
| shipped        | The order has been shipped to the customer and is currently on transit.                                                |
| completed      | The order hass been recieved by the customer                                                                           |
| return_pending | The customer has indecated that they would like to return the order, but it has not yet been received at the warehouse |
| returned       | The order has been returned by the customer and received at the warehouse.                                             |

{% enddocs %}
