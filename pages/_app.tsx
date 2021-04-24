import React from 'react';
import { ChakraProvider, extendTheme } from '@chakra-ui/react';
import '@/src/styles/default.css';
import PropTypes from 'prop-types';

const theme = extendTheme({
  colors: {
    brand: '#0079bf',
    success: '#70b500',
    danger: '#eb5a46',
    info: '#ff9f1a',
    warning: '#f2d600',
    lightblue: '#f2f9fc'
  }
});
function TrelloApp({ Component, pageProps }) {
  return (
    <ChakraProvider theme={theme}>
      <Component {...pageProps} />
    </ChakraProvider>
  );
}

TrelloApp.propTypes = {
  pageProps: PropTypes.object,
  Component: PropTypes.element
};

export default TrelloApp;