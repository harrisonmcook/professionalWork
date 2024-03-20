import React from "react";
import { Autocomplete } from "@react-google-maps/api";
import { Field, ErrorMessage } from "formik";
import PropTypes from "prop-types";

function LocationsAutoComplete(props) {
  return (
    <Autocomplete onLoad={props.onLoad} onPlaceChanged={props.onPlaceChanged}>
      <div className="mb-3 ">
        <label className="form-label" htmlFor="formGridAddress1">
          Address
        </label>

        <Field
          name="lineOne"
          placeholder="1234 Main St"
          id="formGridAddress1"
          className="form-control"
          onChange={(e) => {
            props.setFieldValue("lineOne", e.currentTarget.value);
            props.onDataChange({
              ...props.values,
              lineOne: e.currentTarget.value,
            });
          }}
        />

        <ErrorMessage name="lineOne" component="div" className="has-error" />
      </div>
    </Autocomplete>
  );
}
LocationsAutoComplete.propTypes = {
  onLoad: PropTypes.func,
  onPlaceChanged: PropTypes.func,
  setFieldValue: PropTypes.func,
  onDataChange: PropTypes.func,
  values: PropTypes.shape({
    locationTypeId: PropTypes.string,
    lineOne: PropTypes.string,
    lineTwo: PropTypes.string,
    city: PropTypes.string,
    zip: PropTypes.string,
    stateId: PropTypes.number,
    latitude: PropTypes.number,
    longitude: PropTypes.number,
  }),
};
export default LocationsAutoComplete;
//
