import React, { FC } from 'react';
import { Button, Image, Flex, Box, Spacer } from '@chakra-ui/react';
import Link from 'next/link';
import PropTypes from 'prop-types';
import { useAppSelector } from '@/src/hooks';
import { GrLogout } from 'react-icons/gr';

type IProps = {
  bg?: string;
};

const NavBar: FC<IProps> = ({ bg }) => {
  const user = useAppSelector((state) => state.user);

  const logout = async () => {
    const URL = '/api/logout';

    const response = await fetch(URL, {
      method: 'POST',
      mode: 'cors',
      cache: 'no-cache',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
      },
      redirect: 'follow',
      referrerPolicy: 'no-referrer',
      body: JSON.stringify({}),
    });

    const responseInJson = await response.json();

    if (responseInJson.message === 'success') {
      window.location.href = `${window.location.origin}/login`;
    }
  };

  const renderButton = (label: string, link?: string, onClick?: () => void) => (
    <Button
      fontSize={link ? '20' : 'md'}
      color={link ? 'brand' : 'white'}
      colorScheme={!link ? 'green' : undefined}
      variant={link ? 'link' : undefined}
      float="right"
      mr="2"
      pr="2"
      onClick={onClick}
    >
      {link ? <Link href={link}>{label}</Link> : label}
    </Button>
  );

  const renderButtons = () => {
    if (user?.isValid) {
      return renderButton(<GrLogout />, undefined, logout);
    }

    return (
      <>
        {renderButton('Log in', '/login')}
        {renderButton('Sign up', '/signup')}
      </>
    );
  };

  return (
    <Box bg={bg} boxShadow="md">
      <Flex>
        <Image height="8" src="/trello-logo.svg" alt="brand logo" m="5" />
        <Spacer />
        {renderButtons()}
      </Flex>
    </Box>
  );
};

NavBar.propTypes = {
  bg: PropTypes.string,
};

export default NavBar;
