import React, { useState, useEffect } from "react";
import "rc-pagination/assets/index.css";
import locale from "rc-pagination/lib/locale/en_US";
import debug from "yellowbrick-debug";
import userService from "services/userService";
import MappedUsers from "./MappedUsers";
import Pagination from "rc-pagination";
import { Formik, Form, Field } from "formik";
import "../clients/clientlist.css";

function UsersList() {
  const [users, setUsers] = useState({
    userList: [],
    userRows: [],
    searchedUsers: [],
    pageSize: 10,
    totalCount: 0,
    currentPage: 1,
    searchInput: "",
    isUserFound: true,
    isSearching: false,
  });
  const _logger = debug.extend("UserList");

  useEffect(() => {
    if (users.searchInput !== "") {
      userService
        .searchPaginate(
          users.currentPage - 1,
          users.pageSize,
          users.searchInput
        )
        .then(onSearchSuccess)
        .catch(onSearchError);
    } else {
      userService
        .getAllPaginated(users.currentPage - 1, users.pageSize)
        .then(onSelectAllSuccess)
        .catch(onSelectAllError);
    }
  }, [users.currentPage, users.searchInput]);

  const onSelectAllSuccess = (response) => {
    _logger("selectAll running", response);
    setUsers((prevState) => {
      const uList = { ...prevState };
      uList.userList = response.item.pagedItems;
      uList.userRows = response.item.pagedItems.map(userMap);
      uList.totalCount = response.item.totalCount;

      return uList;
    });
  };
  const onSelectAllError = (err) => {
    _logger("selectAll Failed:", err);
  };
  const onSearchClick = (value) => {
    if (value.query !== "") {
      setUsers((prevState) => {
        const setQuery = { ...prevState };
        setQuery.searchInput = value.query;
        setQuery.currentPage = 1;

        return setQuery;
      });
    }
  };
  const onSearchSuccess = (response) => {
    setUsers((prevState) => {
      const searchData = { ...prevState };
      searchData.searchedUsers = response.item.pagedItems.map(userMap);
      searchData.totalSearchCount = response.item.totalCount;
      searchData.isSearching = true;
      searchData.isUserFound = true;

      return searchData;
    });
  };
  const onSearchError = (err) => {
    _logger("Search Failed:", err);
    setUsers((prevState) => {
      const setToggle = { ...prevState };
      setToggle.isUserFound = false;

      return setToggle;
    });
  };
  const userMap = (aUser) => {
    return (
      <MappedUsers
        useDefaultAvatar={useAvatarDefault}
        addCount={addCount}
        user={aUser}
        key={aUser.id}
      />
    );
  };
  const addCount = () => {
    setUsers((prevState) => {
      const setCount = { ...prevState };
      setCount.updateCount++;
      return setCount;
    });
  };
  const onPageChange = (page) => {
    setUsers((prevState) => {
      const newPage = { ...prevState };
      newPage.currentPage = page;
      return newPage;
    });
  };
  const onShowAllClick = (values) => {
    if (values.query) {
      values.query = "";
    }

    setUsers((prevState) => {
      const toggle = { ...prevState };
      toggle.isSearching = false;
      toggle.isUserFound = true;
      toggle.dependencyCount = 0;
      toggle.searchInput = "";
      toggle.currentPage = 1;

      return toggle;
    });
  };
  const useAvatarDefault = (e) => {
    e.target.src =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY5GfGomQwUzWsCqesYfd0TNe6MAg0cnsfiQ&usqp=CAU";
  };
  return (
    <div className="container">
      <div className="row">
        <div className="col-lg-12 col-md-12 col-sm-12">
          <div className="border-bottom mb-4 d-md-flex align-items-center justify-content-between">
            <div className="mb-3 mb-md-0">
              <h1 className="mb-1 h2 fw-bold">Users List</h1>
            </div>
            <div>
              <Formik
                enableReinitialize={true}
                initialValues={{ query: "" }}
                onSubmit={onSearchClick}
              >
                {({ values }) => (
                  <Form>
                    <div className="mb-lg-0 pt-4 col-lg-12 col-md-12 col-sm-12 d-flex">
                      <div className="d-flex align-items-center">
                        <Field
                          type="text"
                          name="query"
                          className="form-control me-2"
                          placeholder="Search Client List"
                        />
                        <button type="submit" className="btn btn-primary">
                          Search
                        </button>
                      </div>
                      {users.isSearching && (
                        <button
                          type="reset"
                          className="btn btn-primary ms-2"
                          onClick={() => onShowAllClick(values)}
                        >
                          Show All
                        </button>
                      )}
                    </div>
                  </Form>
                )}
              </Formik>
              {users.isUserFound ? (
                <h6>&nbsp;</h6>
              ) : (
                <h6 className="ms-1 text-danger">User Not Found</h6>
              )}
            </div>
          </div>
          <div className="card bg-white">
            <div className="p-0 card-body ">
              <div className=" overflow-hidden"></div>
              <div className="table-responsive ">
                <table
                  role="table"
                  className="text-nowrap table text-center align-middle table-light"
                >
                  <thead className="table-light">
                    <tr role="row">
                      <th colSpan={1} role="columnheader">
                        ID
                      </th>
                      <th colSpan={1} role="columnheader">
                        NAME
                      </th>
                      <th colSpan={1} role="columnheader">
                        EMAIL
                      </th>
                      <th colSpan={1} role="columnheader">
                        STATUS
                      </th>
                    </tr>
                  </thead>
                  <tbody role="rowgroup">
                    {users.isSearching ? users.searchedUsers : users.userRows}
                  </tbody>
                </table>
              </div>
              <div className="pb-3 active-page inactive-page carat-style hover-color ">
                <Pagination
                  onChange={onPageChange}
                  current={users.currentPage}
                  total={
                    users.isSearching
                      ? users.totalSearchCount
                      : users.totalCount
                  }
                  pageSize={users.pageSize}
                  locale={locale}
                  className="text-center"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default UsersList;
