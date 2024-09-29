import { Button, Flex, Modal, TextArea } from '../../components';
import { NameInputModalData } from './Types';
import { useState } from 'react';

export const NameInputModal = (props: NameInputModalData) => {
  const { label, button_text, onSubmit, onBack } = props;
  const [input, setInput] = useState('');

  return (
    <Modal>
      <Flex direction="column">
        <Flex.Item fontSize="16px" maxWidth="90vw" mb={1}>
          {label}:
        </Flex.Item>

        <Flex.Item mr={2} mb={1}>
          <TextArea
            fluid
            height="10vh"
            width="70vw"
            backgroundColor="black"
            textColor="white"
            onInput={(_, value) => {
              setInput(value.substring(0, 150));
            }}
            value={input}
          />
        </Flex.Item>

        <Flex.Item>
          <Button
            content={button_text}
            color="good"
            tooltipPosition="right"
            onClick={() => {
              onSubmit(input);
              setInput('');
            }}
          />
          <Button content="Cancel" color="bad" onClick={onBack} />
        </Flex.Item>
      </Flex>
    </Modal>
  );
};
