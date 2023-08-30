import React from "react";
import PropTypes from "prop-types";
import debug from "yellowbrick-debug";
import userService from "services/userService";
import toastr from "toastr";

function MappedUsers({ user, useDefaultAvatar }) {
  const _logger = debug.extend("mappedUsers");
  const onFormFieldChange = (event) => {
    userService
      .changeStatus(user.email, event.target.value)
      .then(onStatusSuccess)
      .catch(onStatusFail);
  };

  const onStatusSuccess = () => {
    toastr.success(`${user.firstName} ${user.lastName}'s status updated`);
  };
  const onStatusFail = (e) => {
    _logger(e);
    toastr.error(`Couldn't update ${user.firstName} ${user.lastName}'s status`);
  };

  return (
    <tr role="row">
      <td role="cell">{user.id}</td>
      <td role="cell">
        <div className="row">
          <div className="col-4">
            <div className="image-container">
              <img
                src={
                  user.avatarUrl
                    ? user.avatarUrl
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY5GfGomQwUzWsCqesYfd0TNe6MAg0cnsfiQ&usqp=CAU"
                }
                className="avatarUrl me-2"
                alt="..."
                onError={useDefaultAvatar}
              />
            </div>
          </div>
          <div className="col-1 pt-3">
            {user.mi
              ? `${user.firstName} ${user.mi} ${user.lastName}`
              : `${user.firstName} ${user.lastName}`}
          </div>
        </div>
      </td>
      <td role="cell">{user.email}</td>
      <td role="cell">
        <select
          onChange={onFormFieldChange}
          className="form-select"
          aria-label="Default select example"
          name="stausId"
          id="formGridStatusId"
        >
          <option value={user.status.id}>{user.status.name}</option>
          <option value={user.status.id === 1 ? 2 : 1}>
            {user.status.name === "Active" ? "Inactive" : "Active"}
          </option>
        </select>
      </td>
    </tr>
  );
}

MappedUsers.propTypes = {
  user: PropTypes.shape({
    id: PropTypes.number.isRequired,
    firstName: PropTypes.string.isRequired,
    lastName: PropTypes.string.isRequired,
    mi: PropTypes.string,
    avatarUrl: PropTypes.string,
    email: PropTypes.string.isRequired,
    status: PropTypes.shape({
      id: PropTypes.number,
      name: PropTypes.string,
    }),
  }).isRequired,
  addCount: PropTypes.func,
  useDefaultAvatar: PropTypes.func,
};
export default MappedUsers;
